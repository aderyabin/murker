module V1
  class PetsController < ActionController::API
    ALLOWED_ATTRIBUTES = ['name', 'weight'].freeze

    def index
      render json: keep_selected_attributes(Pet.all, params)
    end

    def show
      pet = Pet.find(params[:id])
      render json: pet
    end

    private

    def keep_selected_attributes(pets, params)
      selected_attributes =
        params.select { |key, value| key.in?(ALLOWED_ATTRIBUTES) && value }

      return pets unless selected_attributes.present?

      pets.map do |pet|
        {}.tap do |filtered_pet|
          selected_attributes.each do |attribute|
            filtered_pet[attribute] = pet[attribute]
          end
        end
      end
    end
  end
end
