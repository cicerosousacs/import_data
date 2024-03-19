require 'rails_helper'

RSpec.describe "Auths", type: :request do
  describe "GET /sign_in" do
    it "returns http success" do
      get "/auth/sign_in"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /sign_out" do
    it "returns http success" do
      get "/auth/sign_out"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /change_password" do
    it "returns http success" do
      get "/auth/change_password"
      expect(response).to have_http_status(:success)
    end
  end

end
