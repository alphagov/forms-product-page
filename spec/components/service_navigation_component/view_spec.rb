require "rails_helper"

def normalize_html(html)
  Nokogiri::XML(html, &:noblanks).to_xhtml(indent: 2)
end

RSpec.describe ServiceNavigationComponent::View, type: :component do
  let(:navigation_items) do
    [
      { text: "Features", href: "/features" },
      { text: "Support", href: "/support" },
    ]
  end

  let(:service_navigation_component) do
    described_class.new(navigation_items:)
  end

  let(:current_page) { "/" }

  before do
    with_request_url current_page do
      render_inline service_navigation_component
    end
  end

  describe "render" do
    it "has the app-service-navigation class" do
      expect(page).to have_css(".app-service-navigation")
    end

    context "when no sign-in link is supplied" do
      it "has no items with the app-service-navigation__item--featured" do
        expect(page).not_to have_css(".app-service-navigation__item--featured")
        expect(page).not_to have_link("Sign in")
      end
    end

    context "when a sign-in link is supplied" do
      let(:service_navigation_component) do
        described_class.new(navigation_items:, featured_link: { text: "Sign in", href: "/sign-in" })
      end

      it "has an item with the app-service-navigation__item--featured" do
        expect(page).to have_css(".app-service-navigation__item--featured", text: "Sign in")
        expect(page).to have_link("Sign in", href: "/sign-in")
      end
    end

    context "when on the homepage" do
      it "renders the navigation items as inactive" do
        expect(page).not_to have_selector(
          ".govuk-service-navigation__item.govuk-service-navigation__item--active",
        )
      end

      it "inverts the colours" do
        expect(page).to have_selector(
          ".govuk-service-navigation.govuk-service-navigation--inverse",
        )
      end
    end

    %w[features support].each do |view|
      context "when on the #{view} page" do
        let(:current_page) { "/#{view}" }

        it "renders the #{view} navigation item as active" do
          expect(
            page.find(".govuk-service-navigation__item", text: view.capitalize),
          ).to match_selector ".govuk-service-navigation__item--active"
        end

        it "does not invert the colours" do
          expect(page).not_to have_selector(
            ".govuk-service-navigation.govuk-service-navigation--inverse",
          )
        end
      end
    end
  end
end
