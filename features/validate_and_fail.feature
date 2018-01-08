Feature: validate interaction and fails given schema already exists and does not match

  When you write rspec test with :murker tag it validates interaction over existing schema and fails if schema does not match

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
            get '/v1/martians/1.json'

            expect(response).to be_success
          end
        end
      end
      """
    Given a file named "spec/murker/v1/martians/GET.yml" with:
      """yml
      ---
      openapi: 3.0.0
      info:
        title: Generated by Murker
        version: 0.1.0
      paths:
        "/v1/martians":
          get:
            responses:
              "'200'":
                description: GET /v1/martians -> 200
                content:
                  application/json:
                    schema:
                      type: array
                      minItems: 1
                      uniqueItems: true
                      items:
                        type: object
                        required:
                        - id
                        - name
                        - age
                        - thisIsGonnaFail
                        properties:
                          id:
                            type: integer
                          name:
                            type: string
                          age:
                            type: integer
      """

    Given a file named "spec/murker/v1/martians/__id/GET.yml" with:
      """yml
      ---
      openapi: 3.0.0
      info:
        title: Generated by Murker
        version: 0.1.0
      paths:
        "/v1/martians/{id}":
          get:
            parameters:
            - in: path
              name: id
              description: id
              schema:
                type: integer
              required: true
              example: '1'
            responses:
              "'200'":
                description: GET /v1/martians/:id -> 200
                content:
                  application/json:
                    schema:
                      type: object
                      required:
                      - id
                      - name
                      - age
                      - thisIsGonnaFailToo
                      properties:
                        id:
                          type: integer
                        name:
                          type: string
                        age:
                          type: integer
      """

  When I run `bin/rspec spec/requests/martians_spec.rb`
  Then the example should fail
  Then the output should contain failures:
    """
    Murker::ValidationError:
      Interaction 'GET /v1/martians' failed with the following reason:
       [{"op"=>"remove", "path"=>"/paths/~1v1~1martians/get/responses/'200'/content/application~1json/schema/items/required/3", "was"=>"thisIsGonnaFail"}]

       Interaction 'GET /v1/martians/:id' failed with the following reason:
       [{"op"=>"remove", "path"=>"/paths/~1v1~1martians~1{id}/get/responses/'200'/content/application~1json/schema/required/3", "was"=>"thisIsGonnaFailToo"}]
    """
