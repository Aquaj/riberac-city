module My
  class PlacesController < ApplicationController

    def index
      @places = current_user.places
    end

    def new
      @place = current_user.places.new
    end

    def create
      if @place = current_user.places.create(permitted_params)
        redirect_to @place
      else
        render 'new'
      end
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
      current_user.places.find(params[:place_id])
    end

    def permitted_params
      params.require(:place_attributes)
            .permit(:address, :price, :transaction_type,
                    :surface, :ges,   :energy_class)
    end
  end
end
