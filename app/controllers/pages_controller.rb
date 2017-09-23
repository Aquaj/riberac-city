class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @categories = Category.includes(:options)
    @places = Place.all.decorate
  end

  private
end
