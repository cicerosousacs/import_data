require 'rails_helper'

RSpec.describe "RegistrationSituations", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/registration_situation/index"
      expect(response).to have_http_status(:success)
    end
  end

end
