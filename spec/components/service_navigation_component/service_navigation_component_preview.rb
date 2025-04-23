class ServiceNavigationComponent::ServiceNavigationComponentPreview < ViewComponent::Preview
  def default
    render(ServiceNavigationComponent::View.new)
  end

  def with_navigation_links
    render(ServiceNavigationComponent::View.new(navigation_items: [
      { text: "Get Started", href: "/get-started" },
      { text: "Features", href: "/features" },
      { text: "Support", href: "/support" },
      { text: "Sign in", href: "/sign-in" },
    ]))
  end
end
