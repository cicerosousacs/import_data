require 'rails_helper'

RSpec.describe "Searches", type: :request do
  describe "GET /searchuniq" do
    it "returns http success" do
      get "/search/searchuniq"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /searchall" do
    it "returns http success" do
      get "/search/searchall"
      expect(response).to have_http_status(:success)
    end
  end

end
