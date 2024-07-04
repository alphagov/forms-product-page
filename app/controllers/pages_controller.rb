# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    render(layout: "layouts/homepage")
  end

  def start; end
  def features; end
  def create_good_forms; end
  def accessibility; end
  def cookies; end
  def privacy; end
end
