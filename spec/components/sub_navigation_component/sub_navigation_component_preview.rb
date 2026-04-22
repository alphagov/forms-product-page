class SubNavigationComponent::SubNavigationComponentPreview < ViewComponent::Preview
  def default
    render(SubNavigationComponent::View.new)
  end

  def with_navigation_items
    render(
      SubNavigationComponent::View.new(
        navigation_items: [
          { text: "Get started", href: "#" },
          { text: "About", href: "#" },
        ],
      ),
    )
  end

  def with_nested_navigation_items
    render(
      SubNavigationComponent::View.new(
        navigation_items: [
          { text: "Get started", href: "#" },
          {
            current: true,
            text: "About",
            href: "#",
            navigation_items: [
              { text: "Features", href: "#" },
              { text: "Forthcoming features", href: "#" },
            ],
          },
        ],
      ),
    )
  end

  def with_nested_navigation_items_not_current_page
    render(
      SubNavigationComponent::View.new(
        navigation_items: [
          { current: true, text: "Get started", href: "#" },
          {
            text: "About",
            href: "#",
            navigation_items: [
              { text: "Features", href: "#" },
              { text: "Forthcoming features", href: "#" },
            ],
          },
        ],
      ),
    )
  end
end
