require "rails_helper"

RSpec.describe "Pages", type: :request do
  describe "GET /index" do
    before do
      get root_path
    end

    it "returns ok" do
      expect(response).to have_http_status(:ok)
    end

    it "has the correct title" do
      expect(Capybara.string(response.body).title).to eq("Create online forms for GOV.UK – GOV.UK Forms")
    end
  end

  static_pages = %w[accessibility privacy using-forms support terms-of-use]

  using_forms_pages = Page.for(:using_forms).all

  (static_pages + using_forms_pages.reject { |page| page.slug == "using_forms" }.map { |page| "using-forms/#{page.route_slug}" }).each do |page|
    describe "GET /#{page}" do
      it "returns ok" do
        get "/#{page}"
        expect(response).to have_http_status(:ok)
      end
    end
  end

  using_forms_pages.reject { |page| page.slug == "using_forms" }.each do |page|
    old_path = "/#{page.route_slug}"
    new_path = "/using-forms/#{page.route_slug}"

    describe "GET #{old_path}" do
      it "redirects to #{new_path}" do
        get old_path
        expect(response).to redirect_to(new_path)
      end
    end
  end

  describe "GET /cookies" do
    before do
      get cookies_path
    end

    it "returns ok" do
      expect(response).to have_http_status(:ok)
    end

    it "does not contain the cookie banner" do
      expect(Capybara.string(response.body)).not_to have_selector("#cookie-banner")
    end
  end

  describe "GET /using-forms/get-started" do
    before do
      get using_forms_page_path(slug: "get-started")
    end

    it "renders the using forms sub-navigation" do
      page = Capybara.string(response.body)
      features_page = Page.for(:using_forms).find_by_slug("features")

      expect(page).to have_selector("nav.app-side-navigation")
      expect(page).to have_link(features_page.title, href: using_forms_page_path(slug: "features"))
      expect(page).to have_selector(".app-side-navigation__item--active", text: "Get started")
    end

    it "orders sub-navigation links from page frontmatter" do
      page = Capybara.string(response.body)
      navigation_link_text = page.all("nav.app-side-navigation li a").map(&:text)

      expect(navigation_link_text).to eq(
        [
          "Using GOV.UK Forms",
          "Get started",
          "How GOV.UK Forms works",
          "How to create a good form using GOV.UK Forms",
          "Processing completed form submissions",
          "Forthcoming features",
        ],
      )
    end
  end

  describe "GET /using-forms/create-good-forms" do
    before do
      get using_forms_page_path(slug: "create-good-forms")
    end

    it "sets page title and description from markdown frontmatter" do
      parsed = Capybara.string(response.body)
      description = Nokogiri::HTML(response.body).at_css('meta[name="description"]')["content"]

      expect(parsed.title).to eq("How to create a good form using GOV.UK Forms – GOV.UK Forms")
      expect(description).to eq("Guidance on creating accessible, high-quality forms using GOV.UK Forms.")
    end
  end
end
