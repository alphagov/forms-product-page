require "rails_helper"

RSpec.describe HeaderComponent::View, type: :component do
  let(:phase_name) { "Beta" }

  let(:header_component) do
    described_class.new(phase_name:)
  end

  before do
    render_inline header_component
  end

  describe "render" do
    it "includes the product name" do
      expect(page).to have_link("GOV.UK Forms", href: "/")
    end

    it "has a full width border" do
      expect(page).to have_css(".govuk-header--full-width-border")
    end
  end
end
