module SubNavigationComponent::SubNavigationItemComponent
  class View < ApplicationComponent
    renders_one :navigation_list, "SubNavigationComponent::SubNavigationListComponent::View"

    attr_reader :text, :href, :navigation_items, :current_path, :current, :with_separator

    def initialize(text:, href: nil, navigation_items: [], current_path: nil, current: false, with_separator: false)
      @current = current
      @text = text
      @href = href

      @navigation_items = navigation_items
      @current_path = current_path
      @with_separator = with_separator

      if navigation_items.any? && render_navigation_list?
        with_navigation_list(navigation_items:, current_path:)
      end

      super()
    end

    def call
      tag.li(**html_attributes) do
        safe_join([
          wrap_link(link_to(text, href, class: "app-sub-navigation__link", **aria_current)),
          navigation_list,
        ].compact)
      end
    end

  private

    def wrap_link(link)
      if current?
        tag.strong(link, class: "app-sub-navigation__active-fallback")
      else
        link
      end
    end

    def current?
      current || auto_current?
    end

    def auto_current?
      return if current_path.blank?

      current_path == href
    end

    def render_navigation_list?
      current? || current_in_navigation_items?
    end

    def current_in_navigation_items?
      navigation_items.any? do |item|
        item[:current] || current_path == item[:href]
      end
    end

    def html_attributes
      {
        class: class_names(
          "app-sub-navigation__item",
          "app-sub-navigation__item--active" => current?,
          "app-sub-navigation__item--with-separator" => with_separator,
        ),
      }
    end

    def aria_current
      { aria: { current: "page" } } if current?
    end
  end
end
