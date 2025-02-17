require "rails_helper"

RSpec.describe "Performances", type: :request do
  describe "GET /index" do
    before do
      get performance_index_path
    end

    it "returns ok" do
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /index.json" do
    it "returns JSON" do
      get performance_index_path(format: :json)

      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end
end
