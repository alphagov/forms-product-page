module ApplicationHelper
  def govuk_assets_path
    "/node_modules/govuk-frontend/dist/govuk/assets"
  end

  def page_title(separator = " – ")
    title = content_for(:title).presence || @using_forms_page&.page_title
    [title, "GOV.UK Forms"].compact.join(separator)
  end

  def set_page_title(title)
    content_for(:title) { title }
  end

  def page_description
    description = content_for(:description).presence || @using_forms_page&.page_description
    tag.meta(name: "description", content: description) if description.present?
  end

  def set_page_description(description)
    content_for(:description) { description.html_safe }
  end

  def page_robots
    directive = content_for(:robots)
    tag.meta(name: "robots", content: directive) if directive.present?
  end

  def set_page_robots(directive)
    content_for(:robots) { directive }
  end

  def meta_items
    {
      t("footer.meta_items.accessibility") => "/accessibility",
      t("footer.meta_items.cookies") => "/cookies",
      t("footer.meta_items.privacy") => "/privacy",
      t("footer.meta_items.terms_of_use") => "/terms-of-use",
    }
  end

  def service_navigation_items
    [
      { text: "Using Forms", href: using_forms_path, active: using_forms_section_active? },
      { text: "Support", href: support_path, active: support_section_active? },
    ]
  end

  def using_forms_navigation_items
    Page.for(:using_forms).navigation_pages.map do |page|
      href = if page.slug == "using_forms"
               using_forms_path
             else
               using_forms_page_path(slug: page.route_slug)
             end

      { text: page.title, href: href }
    end
  end

private

  def using_forms_section_active?
    request.path.start_with?(using_forms_path)
  end

  def support_section_active?
    request.path.start_with?(support_path)
  end
end
