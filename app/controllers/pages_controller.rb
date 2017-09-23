class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @categories = Category.includes(:options)
    @places = matching_places.decorate
  end

  private

  def matching_places
    places = Place.all
    options = selected_options
    places = places.with_options(options) if options.any?
    places.order(created_at: :desc)
  end

  def selected_options
    option_ids = params.permit(:option_ids)[:option_ids]
    Option.where(id: option_ids)
  end
end
