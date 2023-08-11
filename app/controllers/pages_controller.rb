class PagesController < ApplicationController
  def index
    render(layout: "layouts/homepage")
  end

  def features; end
end
