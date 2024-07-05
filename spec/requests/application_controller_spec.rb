# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationController do
  context "when there is a application load balancer trace ID" do
    let(:payloads) { [] }
    let(:payload) { payloads.last }

    let!(:subscriber) do
      ActiveSupport::Notifications.subscribe("process_action.action_controller") do |_, _, _, _, payload|
        payloads << payload
      end
    end

    before do
      get root_path, headers: { HTTP_X_AMZN_TRACE_ID: "Root=1-63441c4a-abcdef012345678912345678" }
    end

    after do
      ActiveSupport::Notifications.unsubscribe(subscriber)
    end

    it "adds the trace ID to the instrumentation payload" do
      expect(payload).to include(trace_id: "Root=1-63441c4a-abcdef012345678912345678")
    end
  end

  describe "#up" do
    it "returns http code 200" do
      get rails_health_check_path
      expect(response).to have_http_status(:ok)
    end
  end
end
