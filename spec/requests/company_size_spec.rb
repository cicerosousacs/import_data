require 'rails_helper'

RSpec.describe "CompanySizes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/company_size/index"
      expect(response).to have_http_status(:success)
    end
  end

end
