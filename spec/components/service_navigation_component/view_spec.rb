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
    context "when on the homepage" do
      it "renders the navigation items as inactive" do
        expect(page).not_to have_selector(
          ".govuk-service-navigation__item.govuk-service-navigation__item--active",
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
      end
    end
  end
end
