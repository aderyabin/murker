Feature: generate two schemas from one test with two interactions

  When you write rspec test with :murker tag it generates schema for all interactions

  Scenario: basic usage
    Given a file named "spec/controllers/martians_controller_spec.rb" with:
      """ruby
      require 'rails_helper'
      require 'murker/spec_helper'

      RSpec.describe MartiansController, type: :request do

        describe "GET #index and martian" do
          it "returns a success response", :murker do
            martian = Martian.create! name: 'spajic', age: 30, id: 1

            get '/martians.json'
            get '/martians/1.json'

            expect(response).to be_success
          end
        end
      end
      """

  When I run `bin/rspec spec/controllers/martians_controller_spec.rb`
  Then the example should pass

  Then a file named "spec/murker/martians/GET.txt" should exist

  Then the file "spec/murker/martians/GET.txt" should contain:
  """yml
  ---
  openapi: 3.0.0
  paths:
    "/martians":
      get:
        responses:
          "'200'":
            content:
              application/json:
                schema:
                  type: array
                  minItems: 1
                  uniqueItems: true
                  items:
                    type: object
                    required:
                    - name
                    - age
                    - ololo
                    properties:
                      name:
                        type: string
                      age:
                        type: integer
                      ololo:
                        type: string
  """

  Then a file named "spec/murker/martians/__id/GET.txt" should exist

  Then the file "spec/murker/martians/__id/GET.txt" should contain:
  """yml
  ---
  openapi: 3.0.0
  paths:
    "/martians/{id}":
      get:
        responses:
          "'200'":
            content:
              application/json:
                schema:
                  type: object
                  required:
                  - name
                  - age
                  - ololo
                  properties:
                    name:
                      type: string
                    age:
                      type: integer
                    ololo:
                      type: string
  """
