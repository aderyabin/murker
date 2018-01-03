module V1
  class PetsController < ApplicationController
    before_action :set_pets
    before_action :set_pet, only: [:show, :edit, :update, :destroy]

    # GET martians/1/pets
    def index
      @pets = @martian.pets
      respond_to do |format|
        format.html {}
        format.json { render json: @pets, each_serializer: PetSerializer }
      end
    end

    # GET martians/1/pets/1
    def show
      respond_to do |format|
        format.html {}
        format.json { render json: @pet }
      end
    end

    # GET martians/1/pets/new
    def new
      @pet = @martian.pets.build
    end

    # GET martians/1/pets/1/edit
    def edit
    end

    # POST martians/1/pets
    def create
      @pet = @martian.pets.build(pet_params)

      if @pet.save
        redirect_to([@pet.martian, @pet], notice: 'Pet was successfully created.')
      else
        render action: 'new'
      end
    end

    # PUT martians/1/pets/1
    def update
      if @pet.update_attributes(pet_params)
        redirect_to([@pet.martian, @pet], notice: 'Pet was successfully updated.')
      else
        render action: 'edit'
      end
    end

    # DELETE martians/1/pets/1
    def destroy
      @pet.destroy

      redirect_to martian_pets_url(@martian)
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_pets
        @martian = Martian.find(params[:martian_id])
      end

      def set_pet
        @pet = @martian.pets.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def pet_params
        params.require(:pet).permit(:name, :weight)
      end
  end
end
