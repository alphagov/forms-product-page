# frozen_string_literal: true

module ApplicationHelper
  def govuk_assets_path
    "/node_modules/govuk-frontend/dist/govuk/assets"
  end

  def page_title(title)
    content_for(:title) { title }
  end

  def branded_page_title(separator = " – ")
    [content_for(:title), "GOV.UK Forms"].compact.join(separator)
  end

  def page_description(description)
    content_for(:description) { description.html_safe }
  end

  def page_description_tag
    description = content_for(:description)
    tag.meta(name: "description", content: description) if description.present?
  end

  def page_robots(directive)
    content_for(:robots) { directive }
  end

  def page_robots_tag
    directive = content_for(:robots)
    tag.meta(name: "robots", content: directive) if directive.present?
  end
end
