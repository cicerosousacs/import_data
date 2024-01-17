class CnaeController < ApplicationController
  def index
    render json: {data: Cnae.list_cnaes}
  end
end
