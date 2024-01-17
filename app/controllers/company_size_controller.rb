class CompanySizeController < ApplicationController
  def index
    render json: {data: CompanySize.list_cnaes}
  end
end
