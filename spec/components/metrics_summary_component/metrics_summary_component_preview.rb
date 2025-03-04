class MetricsSummaryComponent::MetricsSummaryComponentPreview < ViewComponent::Preview
  def default
    render(MetricsSummaryComponent::View.new([{ label: "Processor Time Saved", number: 100 }]))
  end
end
