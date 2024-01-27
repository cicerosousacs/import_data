require 'rails_helper'

RSpec.describe "Counties", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/county/index"
      expect(response).to have_http_status(:success)
    end
  end

end
