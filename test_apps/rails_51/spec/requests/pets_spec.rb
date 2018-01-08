require 'rails_helper'
require 'murker/spec_helper'

RSpec.describe V1::PetsController, type: :request do

  describe "GET pet" do
    it "returns a success response", :murker do
      martian = Martian.create! name: 'spajic', age: 30, id: 1
      martian.pets.create! name: 'chubby', weight: 10, id: 1

      get '/v1/martians/1/pets/1.json'

      expect(response).to be_success
    end
  end
end
