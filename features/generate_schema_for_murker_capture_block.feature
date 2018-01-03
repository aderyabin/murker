Feature: generate schema for test with murker capture block

  When you write rspec test with Murker.capture block it generates schema for network interaction

  Scenario: basic usage
    Given a file named "spec/requests/martians_spec.rb" with:
      """ruby
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
      """

  When I run `bin/rspec spec/requests/martians_spec.rb`
  Then the example should pass

  Then a file named "spec/murker/v1/martians/GET.yml" should exist

  Then the file "spec/murker/v1/martians/GET.yml" should contain:
  """yml
  ---
  openapi: 3.0.0
  paths:
    "/v1/martians":
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
