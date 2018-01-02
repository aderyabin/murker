Feature: basic usage

  When you write rspec test with :murker tag it works as expected

  Scenario: basic usage
    Given a file named "spec/controllers/martians_controller_spec.rb" with:
      """ruby
      require 'rails_helper'
      require 'murker/spec_helper'

      RSpec.describe MartiansController, type: :controller do
        render_views

        describe "GET #index" do
          it "returns a success response", :murker do
            martian = Martian.create! name: 'spajic', age: 30

            get :index, format: :json
            expect(response).to be_success
          end
        end
      end
      """

  When I run `bin/rspec spec/controllers/martians_controller_spec.rb`
  Then the example should pass
  # Then a file named "lurker/api/v1/users/__id-GET.json.yml" should exist
  # Then the file "lurker/api/v1/users/__id-GET.json.yml" should contain exactly:
  #   """yml
  #   ---
  #   description: user
  #   prefix: users management
  #   requestParameters:
  #     description: ''
  #     type: object
  #     additionalProperties: false
  #     required: []
  #     properties: {}
  #   responseCodes:
  #   - status: 200
  #     successful: true
  #     description: ''
  #   responseParameters:
  #     description: ''
  #     type: object
  #     additionalProperties: false
  #     required: []
  #     properties:
  #       id:
  #         description: ''
  #         type: integer
  #         example: 1
  #       name:
  #         description: ''
  #         type: string
  #         example: razum2um
  #       surname:
  #         description: ''
  #         type: string
  #         example: Marley
  #   extensions:
  #     method: GET
  #     path_info: "/api/v1/users/1.json"
  #     path_params:
  #       controller: api/v1/users
  #       action: show
  #       id: '1'

  # """

