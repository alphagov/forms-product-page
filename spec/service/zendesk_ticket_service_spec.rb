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
        .with(body: { "ticket" => {
          "subject" => "Test message",
          "comment" => { "body" => "This is a test ticket." },
          "requester" => { "name" => "Test User", "email" => "test@example.com" },
          "tags" => %w[test],
        } })).to have_been_made
    end

    it "authenticates using secrets from settings" do
      allow(Settings.zendesk).to receive(:api_user).and_return("zendesk_user@test.example")
      allow(Settings.zendesk).to receive(:api_token).and_return("supersecret")

      request = stub_successful_create

      described_class.create!(comment: { body: "Test" })

      expect(request
        .with(headers: {
          "Authorization" => "Basic emVuZGVza191c2VyQHRlc3QuZXhhbXBsZS90b2tlbjpzdXBlcnNlY3JldA==",
        })).to have_been_made
    end

    it "raises an exception if the request fails" do
      stub_request(:post, "https://test.zendesk.com/api/v2/tickets.json")
        .to_return_json(status: 401, body: { "error" => "Couldn't authenticate you" })

      expect {
        described_class.create!(comment: { body: "Test" })
      }.to raise_error(/Creating Zendesk ticket failed/)
    end
  end
end
