module SubNavigationComponent::SubNavigationListComponent
  class View < ApplicationComponent
    renders_many :navigation_items, "SubNavigationComponent::SubNavigationItemComponent::View"

    def initialize(navigation_items: [], current_path: nil, with_separator: false)
      navigation_items = navigation_items.dup

      with_navigation_item(current_path:, with_separator: false, **navigation_items.shift) if with_separator
      navigation_items.each { |ni| with_navigation_item(current_path:, with_separator:, **ni) }

      super()
    end

    def call
      tag.ul(safe_join(navigation_items), **html_attributes)
    end

  private

    def html_attributes
      {
        class: %w[
          app-sub-navigation__list
        ],
      }
    end
  end
end
