# frozen_string_literal: true

module HeaderComponent
  class View < ViewComponent::Base
    attr_accessor :navigation_items, :phase_name

    def initialize(navigation_items: [], phase_name: nil)
      super
      @navigation_items = navigation_items
      @phase_name = phase_name
    end

    def call
      govuk_header(homepage_url:) do |header|
        header.with_product_name(**product_name_with_tag)

        navigation_items.each do |item|
          header.with_navigation_item(**item.to_h)
        end
      end
    end

    private

    def homepage_url
      root_path
    end

    def product_name_with_tag
      {
        name: "#{I18n.t('header.product_name')} #{product_tag}".html_safe
      }
    end

    def product_tag
      govuk_tag(text: phase_name, classes: %w[govuk-phase-banner__content__tag]).html_safe
    end
  end
end
