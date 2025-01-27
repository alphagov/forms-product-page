require "rails_helper"
require_relative "../../../app/lib/lograge/custom_options"

describe Lograge::CustomOptions do
  describe ".call" do
    # rubocop:disable RSpec/VerifiedDoubleReference
    let(:event) { instance_double("Event") }
    # rubocop:enable RSpec/VerifiedDoubleReference
    let(:payload) do
      {
        request_host: "somehost",
        user_ip: "192.168.0.1",
        request_id: "abcd1234",
        exception: "MockException",
      }
    end

    before do
      allow(event).to receive(:payload).and_return(payload)
    end

    it "returns a hash with the correct keys and values" do
      result = described_class.call(event)

      expect(result).to include(
        request_host: "somehost",
        user_ip: "192.168.0.1",
        request_id: "abcd1234",
        exception: "MockException",
      )
    end

    context "when there is no exception in the payload" do
      before { payload.delete(:exception) }

      it "does not include the exception key in the returned hash" do
        result = described_class.call(event)

        expect(result).not_to have_key(:exception)
      end
    end
  end
end
