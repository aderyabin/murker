module V1
  class PetsController < ActionController::API
    def index
      render json: Pet.all
    end

    def show
      pet = Pet.find(params[:id])
      render json: pet
    end
  end
end
