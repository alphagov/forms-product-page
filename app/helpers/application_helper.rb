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
end
