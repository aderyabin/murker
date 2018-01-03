require 'rails_helper'

RSpec.describe "Martians", type: :request do
  describe "GET /martians" do
    it "works! (now write some real specs)" do
      get martians_path
      expect(response).to have_http_status(200)
    end
  end
end
