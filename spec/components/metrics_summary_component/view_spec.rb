require "rails_helper"

RSpec.describe MetricsSummaryComponent::View, type: :component do
  context "when there is data to render" do
    let(:metrics) do
      described_class.new(
        {
          organisations: 100,
          submissions: 209_306,
          published: 118,
        },
      )
    end

    before do
      render_inline(metrics)
    end

    it "renders the component" do
      expect(page).to have_text("published")
      expect(page).to have_text("118")
    end
  end

  context "when there is no data to render" do
    let(:metrics) { described_class.new([]) }

    it "renders an error" do
      render_inline(metrics)

      expect(page).to have_text("No data available")
    end
  end
end
