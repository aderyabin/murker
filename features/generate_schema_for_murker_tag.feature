Feature: generate schema for test with :murker tag

  When you write rspec test with :murker tag it generates schema for network interaction

  Scenario: basic usage
    Given a file named "spec/controllers/martians_controller_spec.rb" with:
      """ruby
      require 'rails_helper'
      require 'murker/spec_helper'

      RSpec.describe MartiansController, type: :request do

        describe "GET #index" do
          it "returns a success response", :murker do
            martian = Martian.create! name: 'spajic', age: 30

            get '/martians.json'
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
