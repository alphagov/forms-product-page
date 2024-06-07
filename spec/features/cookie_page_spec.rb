require "rails_helper"

feature "Cookie page", type: :system do
  describe "Javascript is disabled", js: false do
    before do
      visit cookies_path
    end

    it "form is hidden" do
      expect(page).to have_button("Save cookie settings", visible: :hidden)
    end

    it "does not load in Google Analytics" do
      expect(page).not_to have_selector('script[src*="googletagmanager"]', visible: :hidden)
    end
  end

  describe "Javascript is enabled" do
    before do
      visit cookies_path
    end

    it "form is visible" do
      expect(page).to have_button("Save cookie settings", visible: :visible)
    end

    it "set to false if the consent cookie is not set to true" do
      expect(page).to have_checked_field("No", visible: :hidden)
    end

    it "set to true if the consent cookie is set to true" do
      page.driver.browser.manage.add_cookie(name: "analytics_consent", value: "true", path: "/")
      visit cookies_path

      expect(page).to have_checked_field("Yes", visible: :hidden)
      expect(page).to have_selector('script[src*="googletagmanager"]', visible: :hidden)
    end

    describe "when selecting yes and submitting form" do
      before do
        choose "Yes"
        click_button "Save cookie settings"
      end

      it "sets consent cookie" do
        cookie = page.driver.browser.manage.cookie_named("analytics_consent")

        expect(cookie[:value]).to eq "true"
      end

      it "adds the google tag script" do
        expect(page).to have_selector('script[src*="googletagmanager"]', visible: :hidden)
      end

      it "shows notification banner" do
        expect(page).to have_selector(".govuk-notification-banner")
      end
    end

    describe "selecting no and submitting form" do
      before do
        choose "No"
        click_button "Save cookie settings"
      end

      it "sets consent cookie" do
        cookie = page.driver.browser.manage.cookie_named("analytics_consent")

        expect(cookie[:value]).to eq "false"
      end

      it "does not add the google tag script" do
        expect(page).not_to have_selector('script[src*="googletagmanager"]', visible: :hidden)
      end

      it "shows notification banner" do
        expect(page).to have_selector(".govuk-notification-banner")
      end
    end
  end
end
