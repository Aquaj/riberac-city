class PlacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @categories = Category.includes(:options)

    @places = matching_places
    @places = @places.decorate

    @selected_option_ids = selected_options.pluck(:id)
    @price_range = price_range

    @markers_data = Gmaps4rails.build_markers(@places) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
    end

  end

  def show
    @place = find_place
  end

  def edit
    @place = find_place
  end

  def update
    @place = find_place
    if @place.update(permitted_params)
      redirect_to @place
    else
      render 'edit'
    end
  end

private

  def find_place
    Place.find(params[:id]).decorate
  end

  def permitted_params
    params.require(:place_attributes)
          .permit(:title, :description,      :address,
                  :price, :transaction_type, :surface,
                  :ges,   :energy_class,     pictures: [])
  end

  def matching_places
    places  = Place.all
    options = selected_options
    places  = places.matching_options(options)
    places  = places.where(price: price_range)
    places.order(created_at: :desc)
  end

  def selected_options
    option_ids = params.dig(:search, :option_ids)&.reject(&:blank?)
    option_ids.to_a.any? ? Option.where(id: option_ids) : Option.all
  end

  def price_range
    price_max = params[:search][:price_max].to_i
    min = params[:search][:price_min].to_i
    max = price_max.present? ? price_max : Place.maximum(:price)
    min, max = [max, min] if max < min
    (min..max.to_i)
  end
end
