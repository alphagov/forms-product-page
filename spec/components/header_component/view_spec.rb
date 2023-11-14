require "rails_helper"

RSpec.describe HeaderComponent::View, type: :component do
  let(:navigation_items) do
    [
      { text: "Features", href: "/features" },
      { text: "Support", href: "/support" },
    ]
  end

  let(:phase_name) { "beta" }

  let(:header_component) do
    described_class.new(navigation_items:, phase_name:)
  end

  let(:current_page) { "/" }

  before do
    with_request_url current_page do
      render_inline header_component
    end
  end

  describe "call" do
    context "when on the homepage" do
      it "renders the navigation items as inactive" do
        expect(page).not_to have_selector(
          ".govuk-header__navigation-item.govuk-header__navigation-item--active",
        )
      end
    end

    %w[features support].each do |view|
      context "when on the #{view} page" do
        let(:current_page) { "/#{view}" }

        it "renders the #{view} navigation item as active" do
          expect(
            page.find(".govuk-header__navigation-item", text: view.capitalize),
          ).to match_selector ".govuk-header__navigation-item--active"
        end
      end
    end
  end
end
