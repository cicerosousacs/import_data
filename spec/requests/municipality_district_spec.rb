require 'rails_helper'

RSpec.describe "MunicipalityDistricts", type: :request do
  describe "GET /municipality_from_uf" do
    it "returns http success" do
      get "/municipality_district/municipality_from_uf"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /district_from_municipality" do
    it "returns http success" do
      get "/municipality_district/district_from_municipality"
      expect(response).to have_http_status(:success)
    end
  end

end
