require "rails_helper"

RSpec.describe "Pages", type: :request do
  describe "GET /index" do
    it "returns ok" do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end

  %w[features
     support
     accessibility
     cookies
     privacy].each do |page|
    describe "GET /#{page}" do
      it "returns ok" do
        get "/#{page}"
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
