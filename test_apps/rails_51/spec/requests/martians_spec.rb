require 'rails_helper'
require 'murker/spec_helper'

RSpec.describe V1::MartiansController, type: :request do
  describe "GET #index" do
    it "returns a success response" do
      martian = Martian.create! name: 'spajic', age: 30

      Murker.capture do
        get '/v1/martians.json'
      end

      expect(response).to be_success
    end
  end
end
