require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /list" do
    it "returns http success" do
      get "/user/list"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/user/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/user/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/user/delete"
      expect(response).to have_http_status(:success)
    end
  end

end
