require 'rails_helper'

RSpec.describe "Cnaes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/cnae/index"
      expect(response).to have_http_status(:success)
    end
  end

end
