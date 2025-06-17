# spec/views/layouts/application.html.erb_spec.rb

require "rails_helper"

RSpec.describe "layouts/application", type: :view do
  it "renders the layout with a link to sign in to forms-admin in the header" do
    render

    expect(rendered).to have_link("Sign in", href: Settings.forms_admin.base_url)
  end

  describe "the footer" do
    before do
      render
    end

    it "contains a link to the accessibility statement" do
      expect(rendered).to have_selector(
        ".govuk-footer",
      ) do |footer|
        expect(footer).to have_link(I18n.t("footer.meta_items.accessibility"), href: "/accessibility")
      end
    end

    it "contains a link to the cookies page" do
      expect(rendered).to have_selector(
        ".govuk-footer",
      ) do |footer|
        expect(footer).to have_link(I18n.t("footer.meta_items.cookies"), href: "/cookies")
      end
    end

    it "contains a link to the privacy statement" do
      expect(rendered).to have_selector(
        ".govuk-footer",
      ) do |footer|
        expect(footer).to have_link(I18n.t("footer.meta_items.privacy"), href: "/privacy")
      end
    end

    it "contains a link to the terms of use" do
      expect(rendered).to have_selector(
        ".govuk-footer",
      ) do |footer|
        expect(footer).to have_link(I18n.t("footer.meta_items.terms_of_use"), href: "/terms-of-use")
      end
    end

    it "contains a link to the GDS organisation page" do
      expect(rendered).to have_selector(
        ".govuk-footer",
      ) do |footer|
        expect(footer).to have_link("Government Digital Service", href: "https://www.gov.uk/government/organisations/government-digital-service")
      end
    end
  end
end
