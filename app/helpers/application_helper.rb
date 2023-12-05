module ApplicationHelper
  def govuk_assets_path
    "/node_modules/govuk-frontend/govuk/assets"
  end

  def page_title(separator = " – ")
    [content_for(:title), "GOV.UK Forms"].compact.join(separator)
  end

  def set_page_title(title)
    content_for(:title) { title }
  end

  def page_description
    description = content_for(:description)
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

  def sign_in_button
    form_with url: "/auth/auth0" do |form|
      form.submit "Sign in"
    end
  end
end
