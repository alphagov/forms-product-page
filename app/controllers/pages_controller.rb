class PagesController < ApplicationController
  include PerformanceData
  layout "using_forms", only: %i[using_forms using_forms_page]

  def index
    fetch_data
    render(layout: "layouts/homepage")
  end

  def accessibility; end
  def cookies; end
  def privacy; end
  def terms_of_use; end

  def using_forms
    render_using_forms_page("using_forms")
  end

  def using_forms_page
    render_using_forms_page(params[:slug])
  end

private

  def render_using_forms_page(slug)
    page = Page.for(:using_forms).find_by_slug(slug)
    raise ActionController::RoutingError, "Not Found" unless page

    @using_forms_page = page
    render(template: page.template)
  end
end
