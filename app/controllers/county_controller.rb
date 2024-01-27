class CountyController < ApplicationController
  def index
    render json: {data: County.list_cnaes}
  end
end
