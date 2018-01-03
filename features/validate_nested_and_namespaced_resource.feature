Feature: validate interaction successfully given valid schema already exists for nested and namespaced resource

  When you write rspec test with :murker tag it validates interaction over existing schema

  Scenario: basic usage
    Given a file named "spec/requests/pets_spec.rb" with:
      """ruby
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
      """
    Given a file named "spec/murker/v1/martians/__martian_id/pets/__id/GET.yml" with:
      """yml
      ---
      openapi: 3.0.0
      paths:
        "/v1/martians/{martian_id}/pets/{id}":
          get:
            responses:
              "'200'":
                content:
                  application/json:
                    schema:
                      type: object
                      required:
                      - name
                      - weight
                      properties:
                        name:
                          type: string
                        weight:
                          type: integer
      """

  When I run `bin/rspec spec/requests/pets_spec.rb`
  Then the example should pass
