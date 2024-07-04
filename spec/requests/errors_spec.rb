# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Errors", type: :request do
  describe "Page not found" do
    before do
      get "/404"
    end

    it "returns http code 404" do
      expect(response).to have_http_status(:not_found)
    end

    it "renders the not found template" do
      expect(response.body).to include("Page not found")
    end
  end

  describe "Internal server error" do
    before do
      get "/500"
    end

    it "returns http code 500" do
      expect(response).to have_http_status(:internal_server_error)
    end

    it "renders the internal server error template" do
      expect(response.body).to include("Sorry, there is a problem with the service")
    end
  end
end
