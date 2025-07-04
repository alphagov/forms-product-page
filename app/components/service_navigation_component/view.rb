module ServiceNavigationComponent
  class View < ViewComponent::Base
    include Rails.application.routes.url_helpers

    attr_accessor :navigation_items

    def initialize(navigation_items: [], featured_link: nil)
      super
      @navigation_items = navigation_items
      @featured_link = featured_link
    end

    def call
      add_featured_link if @featured_link.present?

      classes = %w[app-service-navigation]
      classes << "govuk-service-navigation--inverse" if request.fullpath == root_path

      govuk_service_navigation(current_path: request.fullpath,
                               navigation_items:,
                               classes:)
    end

  private

    def add_featured_link
      @navigation_items.push(featured_link_with_classes)
    end

    def featured_link_with_classes
      { **@featured_link, classes: ["app-service-navigation__item", "app-service-navigation__item--featured"] }
    end
  end
end
