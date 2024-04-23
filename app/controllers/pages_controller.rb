class PagesController < ApplicationController
  def index
    render(layout: "layouts/homepage")
  end

  def get_started; end
  def features; end
  def create_good_forms; end
  def accessibility; end
  def cookies; end
  def privacy; end
end
