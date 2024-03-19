require 'rails_helper'

RSpec.describe "SubUsers", type: :request do
  describe "GET /list" do
    it "returns http success" do
      get "/sub_user/list"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/sub_user/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/sub_user/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/sub_user/delete"
      expect(response).to have_http_status(:success)
    end
  end

end
