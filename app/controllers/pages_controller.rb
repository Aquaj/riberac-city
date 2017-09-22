class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @categories = Category.includes(:options)
    @places = Place.where(id: PlaceOption.where(option_id: options.select(:id)).select(:place_id))
  end

  private

  def options
    option_ids = params.permit(:option_ids)[:option_ids].to_a
    Option.where(id: option_ids)
  end
end
