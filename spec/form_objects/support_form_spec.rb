# frozen_string_literal: true

require "rails_helper"

describe SupportForm, type: :model do
  describe "validations" do
    SupportForm::I_NEED_HELP_WITH_OPTIONS.each do |option|
      it "is valid if i_need_help_with is set to #{option}" do
        expect(described_class.new(i_need_help_with: option))
          .to be_valid
      end
    end

    it "is valid to submit if all attributes are present" do
      expect(described_class.new(
               i_need_help_with: "using_forms",
               message: "I need help using GOV.UK Forms",
               name: "A. User",
               email_address: "test@example.com",
             )).to be_valid(:submit)
    end

    %i[i_need_help_with message name email_address].each do |attr|
      it "is not valid to submit if #{attr} is not present" do
        attrs = {
          i_need_help_with: "using_forms",
          message: "I need help using GOV.UK Forms",
          name: "A. User",
          email_address: "test@example.com",
        }
        attrs.delete(attr)

        support_form = described_class.new(**attrs)

        expect(support_form).not_to be_valid(:submit)
        expect(support_form.errors).to be_added attr, :blank
      end
    end

    it "is not valid to submit if i_need_help_with is set to other_government_service" do
      expect(described_class.new(
               i_need_help_with: "other_government_service",
               message: "I need help using GOV.UK Forms",
               name: "A. User",
               email_address: "test@example.com",
             )).not_to be_valid(:submit)
    end

    it "is not valid to submit if email_address is not an email address" do
      support_form = described_class.new(
        i_need_help_with: "using_forms",
        message: "I need help using GOV.UK Forms",
        name: "A. User",
        email_address: "not_an_email_address",
      )

      expect(support_form).not_to be_valid(:submit)
      expect(support_form.errors.where(:email_address, message: :invalid_email)).to be_truthy
    end
  end

  describe "#submit" do
    before do
      allow(ZendeskTicketService).to receive(:create!).and_return(true)
    end

    it "does not submit if user needs help with another government service" do
      support_form = described_class.new(
        i_need_help_with: "other_government_service",
        message: "I need help with my tax return",
        name: "A. User",
        email_address: "test@example.com",
      )

      expect(support_form.submit).to be_falsey
      expect(ZendeskTicketService).not_to have_received(:create!)
    end

    it "submits the user's message as a Zendesk ticket" do
      support_form = described_class.new(
        i_need_help_with: "using_forms",
        message: "I need help with GOV.UK Forms",
        name: "A. User",
        email_address: "test@example.com",
      )

      expect(support_form.submit).to be_truthy
      expect(ZendeskTicketService).to have_received(:create!).with(
        hash_including(
          comment: { body: "I need help with GOV.UK Forms" },
          requester: { name: "A. User", email: "test@example.com" },
        ),
      )
    end

    [
      %w[using_forms govuk_forms_support],
      %w[about_forms govuk_forms_enquiries],
    ].each do |i_need_help_with, tag|
      it "tags the Zendesk ticket with what they need help with" do
        described_class.new(
          i_need_help_with:,
          message: "My message",
          name: "A. User",
          email_address: "test@example.com",
        ).submit

        expect(ZendeskTicketService).to have_received(:create!).with(
          hash_including(
            tags: [tag],
          ),
        )
      end
    end
  end
end
