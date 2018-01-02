Feature: validate interaction and fails given schema already exists and does not match

  When you write rspec test with :murker tag it validates interaction over existing schema and fails if schema does not match

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

            expect(response).to be_success
          end
        end
      end
      """
    Given a file named "spec/murker/martians/GET.txt" with:
      """txt
      GET, /martians, /martians.json, {"controller"=>"martians", "action"=>"index"}, {}, {}, 200, {"name"=>"spajic", "age"=>30, "OOOPS"=>"THIS GONNA CAUSE A VALIDATION ERROR"}
      """

  When I run `bin/rspec spec/controllers/martians_controller_spec.rb`
  Then the example should fail
  Then the output should contain "VALIDATION FAILED"
