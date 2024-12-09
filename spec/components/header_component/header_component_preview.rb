class HeaderComponent::HeaderComponentPreview < ViewComponent::Preview
  def default
    render(HeaderComponent::View.new(navigation_items: [], phase_name: "Beta"))
  end

  def with_navigation_links
    render(HeaderComponent::View.new(navigation_items: [
      { text: "Get Started", href: "/get-started" },
      { text: "Features", href: "/features" },
      { text: "Support", href: "/support" },
      { text: "Sign in", href: "/sign-in" },
    ], phase_name: "Beta"))
  end
end
