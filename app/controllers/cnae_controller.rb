class CnaeController < ApplicationController
  before_action :authenticated?
  
  def index
    render json: {data: Cnae.list_cnaes}
  end
end
