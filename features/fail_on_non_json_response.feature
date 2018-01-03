Feature: fail on non-parsable json response

  When you write rspec test with :murker tag it throws exception if response body is not parsable json

  Scenario: basic usage
    Given a file named "spec/requests/martians_spec.rb" with:
      """ruby
      require 'rails_helper'
      require 'murker/spec_helper'

      RSpec.describe V1::MartiansController, type: :request do

        describe "GET" do
          it "returns a success response" do
            martian = Martian.create! name: 'spajic', age: 30

            Murker.capture do
              get '/v1/martians/1.html'
            end

            expect(response).to be_success
          end
        end
      end
      """

  When I run `bin/rspec spec/requests/martians_spec.rb`
  Then the example should fail

  Then the output should contain failures:
    """
    Murker::MurkerError:
      Murker requires response.body to be parsable JSON, but got ''
    """
