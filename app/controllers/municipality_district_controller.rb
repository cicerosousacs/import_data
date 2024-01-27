class MunicipalityDistrictController < ApplicationController
  before_action :uf_params, only: :municipality_from_uf
  before_action :district_params, only: :district_from_municipality

  def municipality_from_uf
    municipality = Establishment.municipality_from_uf(uf_params[:uf_id])
    
    render json: {data: municipality}
  end

  def district_from_municipality
    district = Establishment.district_from_municipality(district_params[:municipality_id])

    render json: {data: district}
  end

  private

  def uf_params
    params.permit(:uf_id)
  end

  def district_params
    params.permit(:municipality_id)
  end
end
