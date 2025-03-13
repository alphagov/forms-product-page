class PagesController < ApplicationController
  include PerformanceData
  def index
    fetch_data
    render(layout: "layouts/homepage")
  end

  def get_started; end
  def features; end
  def create_good_forms; end
  def accessibility; end
  def cookies; end
  def privacy; end
  def terms_of_use; end
end
