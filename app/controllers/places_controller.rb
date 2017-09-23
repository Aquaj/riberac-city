class PlacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

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
    current_user.places.find(params[:place_id]).decorate
  end

  def permitted_params
    params.require(:place_attributes)
          .permit(:address, :price, :transaction_type,
                  :surface, :ges,   :energy_class, pictures: [])
  end
end
