class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @categories = Category.includes(:options)
    @places = Place.where(id: PlaceOption.where(option_id: options.select(:id)).select(:place_id)).decorate
  end

  private

  def options
    option_ids = params.permit(:option_ids)[:option_ids]
    collection = Option.all
    collection = collection.where(id: option_ids) if option_ids
    collection
  end
end
