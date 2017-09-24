module My
  class PlacesController < ApplicationController

    def index
      @places = current_user.places
    end

    def new
      @place = current_user.places.new
    end

    def create
      @place = current_user.places.create(permitted_params)  
      if @place.save!
        redirect_to my_places_path
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
      params.require(:place)
            .permit(:title, :address, :price, :transaction_type,
                    :surface, :ges,   :energy_class, :description, pictures: [])
            .tap { |param| param[:transaction_type] = param[:transaction_type].to_i if param[:transaction_type]}
    end
  end
end
