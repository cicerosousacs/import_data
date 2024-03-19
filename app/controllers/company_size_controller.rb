class CompanySizeController < ApplicationController
  before_action :authenticated?
  
  def index
    render json: {data: CompanySize.list_cnaes}
  end
end
