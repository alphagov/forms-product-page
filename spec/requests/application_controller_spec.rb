require "rails_helper"

RSpec.describe ApplicationController, type: :request do
  describe "#up" do
    it "returns http code 200" do
      get rails_health_check_path
      expect(response).to have_http_status(:ok)
    end
  end
end
