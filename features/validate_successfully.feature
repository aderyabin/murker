Feature: validate interaction successfully given valid schema already exists

  When you write rspec test with :murker tag it validates interaction over existing schema

  Scenario: basic usage
    Given a file named "spec/requests/martians_spec.rb" with:
      """ruby
      require 'rails_helper'
      require 'murker/spec_helper'

      RSpec.describe V1::MartiansController, type: :request do

        describe "GET #index and martian" do
          it "returns a success response", :murker do
            martian = Martian.create! name: 'spajic', age: 30, id: 1

            get '/v1/martians.json'

            expect(response).to be_success
          end
        end
      end
      """
    Given a file named "spec/murker/v1/martians/GET.yml" with:
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

  When I run `bin/rspec spec/requests/martians_spec.rb`
  Then the example should pass
