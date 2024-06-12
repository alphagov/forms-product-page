require "rails_helper"

feature "Cookie banner", type: :system do
  describe "when JavaScript is disabled", js: false do
    it "is hidden" do
      visit root_path
      expect(page).not_to have_selector("#cookie-banner")
    end

    it "does not load in Google Analytics" do
      visit root_path
      expect(page).not_to have_selector('script[src*="googletagmanager"]', visible: :hidden)
    end
  end

  describe "when JavaScript is enabled" do
    it "is visible if there is no consent cookie" do
      visit root_path
      expect(page).to have_selector("#cookie-banner")
    end

    it "is hidden if the consent cookie version is valid" do
      visit root_path
      %w[true false].each do |consent|
        page.driver.browser.manage.add_cookie(name: "analytics_consent", value: consent, path: "/")
        page.refresh

        expect(page).not_to have_selector("#cookie-banner")
      end
    end

    describe "when clicking 'Accept' button" do
      before do
        visit root_path
        click_button "Accept analytics cookies"
      end

      it "sets the consent cookie and adds the google tag script to the page" do
        cookie = page.driver.browser.manage.cookie_named("analytics_consent")
        expect(cookie[:value]).to eq "true"
      end

      it "adds the google tag script" do
        expect(page).to have_selector('script[src*="googletagmanager"]', visible: :hidden)
      end

      it "hides the cookie message" do
        expect(page).not_to have_selector("#cookie-banner")
      end
    end
  end

  describe "when clicking 'Reject' button" do
    before do
      visit root_path
      click_button "Reject analytics cookies"
    end

    it "sets the consent cookie to 'false'" do
      cookie = page.driver.browser.manage.cookie_named("analytics_consent")
      expect(cookie[:value]).to eq "false"
    end

    it "hides the cookie message" do
      expect(page).not_to have_selector("#cookie-banner")
    end
  end

  describe "cookie page link" do
    it "leads to the cookies page" do
      visit root_path
      expect(page.find("#cookie-banner")).to have_link("How we use cookies", href: cookies_path)
    end
  end
end
