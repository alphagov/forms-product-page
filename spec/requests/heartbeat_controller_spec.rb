require "rails_helper"

describe HeartbeatController, type: :request do
  describe "GET /ping" do
    it "returns PONG" do
      get "/ping"

      expect(response.body).to eq "PONG"
      expect(response).to have_http_status(:ok)
    end
  end
end
