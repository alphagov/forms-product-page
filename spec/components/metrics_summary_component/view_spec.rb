require "rails_helper"

RSpec.describe MetricsSummaryComponent::View, type: :component do
  let(:label) { "Processor Time Saved" }
  let(:number) { 100 }
  let(:metrics) { described_class.new(label:, number:) }

  before do
    render_inline(metrics)
  end

  it "renders the component" do
    expect(page).to have_text("Processor Time Saved")
    expect(page).to have_text("100")
  end

  context "when there  is no data to render" do
    let(:number) { nil }

    it "renders an error" do
      expect(page).to have_text("No data available")
    end
  end
end
