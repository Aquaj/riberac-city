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
    places = places.with_options(options)
    places = places.where(price: price_range)
    places.order(created_at: :desc)
  end

  def selected_options
    option_ids = params.permit(:option_ids)[:option_ids]
    option_ids.any? ? Option.where(id: option_ids) : Option.all
  end

  def price_range
    min = params[:min_price] || 0
    max = params[:max_price] || Place.maximum(:price)
    min, max = [max, min] if max > min
    (min..max)
  end
end
