class HomeController < ApplicationController

layout "layout_landing"

  def index
    @categories = Category.all
  end

  def about
  end

end
