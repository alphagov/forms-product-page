class HeaderComponent::HeaderComponentPreview < ViewComponent::Preview
  def default
    render(HeaderComponent::View.new(phase_name: "Beta"))
  end
end
