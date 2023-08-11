require "rails_helper"

RSpec.describe "Pages", type: :request do
  describe "GET /index" do
    it "returns ok" do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /features" do
    it "returns ok" do
      get "/features"
      expect(response).to have_http_status(:ok)
    end
  end
end
