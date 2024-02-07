require 'rails_helper'

RSpec.describe "Exports", type: :request do
  describe "GET /export_to_xlsx" do
    it "returns http success" do
      get "/export/export_to_xlsx"
      expect(response).to have_http_status(:success)
    end
  end

end
