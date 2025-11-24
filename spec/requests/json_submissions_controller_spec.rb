require "rails_helper"

RSpec.describe JsonSubmissionsController do
  describe "GET /v1/schema" do
    before do
      get json_submissions_schema_v1_path
    end

    it "returns ok" do
      expect(response).to have_http_status(:ok)
    end

    it "has content-type application/json" do
      expect(response.headers["content-type"]).to eq "application/json; charset=utf-8"
    end

    it "includes the URL as the $id" do
      expect(JSON.parse(response.body)["$id"]).to eq json_submissions_schema_v1_url
    end
  end
end
