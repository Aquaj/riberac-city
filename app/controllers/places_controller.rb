class PlacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_place, only: [:show, :edit, :update]
  before_action :set_categories, only: [:index, :show]

  def index
    @places = matching_places.decorate
    @markers_data = Gmaps4rails.build_markers(@places) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
    end
  end

  def show
  end

  def edit
  end

  def update
    if @place.update(permitted_params)
      redirect_to @place
    else
      render 'edit'
    end
  end

private

  def set_categories
    @categories = Category.includes(:options)
  end

  def find_place
    @place = Place.find(params[:id]).decorate
  end

  def permitted_params
    params.require(:place_attributes)
          .permit(:title, :description,      :address,
                  :price, :transaction_type, :surface,
                  :ges,   :energy_class,     pictures: [])
  end

  def matching_places
    places = Place.all
    options = selected_options
    places = places.matching_options(options)
    places = places.where(price: price_range)
    places.order(created_at: :desc)
  end

  def selected_options
    option_ids = params.permit(:option_ids)[:option_ids]
    option_ids.to_a.any? ? Option.where(id: option_ids) : Option.all
  end

  def price_range
    min = params[:min_price] || 0
    max = params[:max_price] || Place.maximum(:price)
    min, max = [max, min] if max < min
    (min..max)
  end
end
