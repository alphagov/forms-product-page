# frozen_string_literal: true

require "rails_helper"

RSpec.describe Sentry do
  let(:test_dsn) { "https://fake@test-dsn/1" }

  before do
    allow(Settings.sentry).to receive(:dsn).and_return(test_dsn)

    load "config/initializers/sentry.rb"

    setup_sentry_test
  end

  after do
    teardown_sentry_test
  end

  context "when an exception is raised containing personally identifying information" do
    let(:support_form) { SupportForm.new(email_address: "user@example.org") }

    before do
      raise "Something went wrong: #{support_form.inspect}"
    rescue RuntimeError => e
      described_class.capture_exception(e)
    end

    it "scrubs email addresses from everywhere in the event" do
      expect(last_sentry_event.to_hash.to_s).not_to include "submission-email@test.example"
    end

    it "replaces the email address in the exception with a comment" do
      expect(last_sentry_event.to_hash[:exception][:values].first[:value]).to include "[Filtered (client-side)]"
    end

    it "keeps the rest of the exception message" do
      expect(last_sentry_event.to_hash[:exception][:values].first[:value]).to include "Something went wrong"
    end
  end

  context "when an breadcrumb is sent containing personally identifying information" do
    before do
      described_class.add_breadcrumb(
        Sentry::Breadcrumb.new(
          category: "spec.integration.sentry_spec",
          data: {
            action: "test_breadcrumb",
            params: {
              forms_submission_form: {
                temporary_submission: "new-submission-email@test.example",
                notify_response_id: "some-random-number-0000",
              },
            },
          },
        ),
      )

      described_class.capture_message("breadcrumbs test")
    end

    it "scrubs email addresses from everywhere in the event" do
      expect(last_sentry_event.to_hash.to_s).not_to include "new-submission-email@test.example"
    end

    it "replaces the email address in the breadcrumbs with a comment" do
      expect(last_sentry_event.to_hash[:breadcrumbs][:values].last[:data]["params"]["forms_submission_form"]["temporary_submission"]).to eq "[Filtered (client-side)]"
    end
  end
end
