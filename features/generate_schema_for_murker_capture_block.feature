Feature: generate schema for test with murker capture block

  When you write rspec test with Murker.capture block it generates schema for network interaction

  Scenario: basic usage
    Given a file named "spec/controllers/martians_controller_spec.rb" with:
      """ruby
      require 'rails_helper'
      require 'murker/spec_helper'

      RSpec.describe MartiansController, type: :controller do
        render_views

        describe "GET #index" do
          it "returns a success response" do
            martian = Martian.create! name: 'spajic', age: 30

            Murker.capture do
              get :index, format: :json
            end

            expect(response).to be_success
          end
        end
      end
      """

  When I run `bin/rspec spec/controllers/martians_controller_spec.rb`
  Then the example should pass

  Then a file named "spec/murker/martians/GET.txt" should exist

  Then the file "spec/murker/martians/GET.txt" should contain exactly:
  """txt
  GET, /martians, /martians.json, {"controller"=>"martians", "action"=>"index"}, {}, {}, 200, {"name"=>"spajic", "age"=>30, "ololo"=>"OLOLO"}
  """
