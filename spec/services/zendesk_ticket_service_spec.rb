require "rails_helper"

describe ZendeskTicketService do
  before do
    allow(Settings.zendesk).to receive(:subdomain).and_return("test")
  end

  describe "#create" do
    let(:stub_successful_create) do
      stub_request(:post, "https://test.zendesk.com/api/v2/tickets.json")
        .to_return { |request| { status: 201, body: request.body } }
    end

    it "creates a Zendesk ticket" do
      request = stub_successful_create

      described_class.create!(
        comment: { body: "This is a test ticket." },
        requester: { name: "Test User", email: "test@example.com" },
        subject: "Test message",
        tags: %w[test],
      )

      expect(request
        .with(body: { "ticket" => a_hash_including({
          "subject" => "Test message",
          "comment" => { "body" => "This is a test ticket." },
          "requester" => { "name" => "Test User", "email" => "test@example.com" },
          "tags" => %w[test],
        }) })).to have_been_made
    end

    it "authenticates using secrets from settings" do
      allow(Settings.zendesk).to receive_messages(api_user: "zendesk_user@test.example", api_token: "supersecret")

      request = stub_successful_create

      described_class.create!(comment: { body: "Test" })

      expect(request
        .with(headers: {
          "Authorization" => "Basic emVuZGVza191c2VyQHRlc3QuZXhhbXBsZS90b2tlbjpzdXBlcnNlY3JldA==",
        })).to have_been_made
    end

    it "assigns the ticket to the correct group and organisation" do
      allow(Settings.zendesk).to receive(:defaults).and_return({
        group_id: "forms",
        organization_id: "gds",
      })
      request = stub_successful_create

      described_class.create!(comment: { body: "Test" })

      expect(request
        .with(body: { "ticket" => a_hash_including({
          "group_id" => "forms",
          "organization_id" => "gds",
        }) })).to have_been_made
    end

    context "when Zendesk returns an error" do
      before do
        allow(Settings.sentry).to receive(:dsn).and_return("foo")
        load "config/initializers/sentry.rb"
        setup_sentry_test

        stub_request(:post, "https://test.zendesk.com/api/v2/tickets.json")
          .to_return_json(status: 401, body: { "error" => "Couldn't authenticate you" })
      end

      after do
        teardown_sentry_test
      end

      it "raises an exception and sends it to Sentry" do
        expect {
          described_class.create!(comment: { body: "Test" })
        }.to raise_error ZendeskTicketService::CreateFailedError
        expect(last_sentry_event).to be_present
        expect(last_sentry_event[:extra][:zendesk_error_message]).to eq("Couldn't authenticate you")
        expect(last_sentry_event[:extra][:zendesk_response_code]).to eq("401")
      end
    end
  end
end
