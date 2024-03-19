class RegistrationSituationController < ApplicationController
  before_action :authenticated?
  
  def index
    render json: {data: RegistrationSituation.list_cnaes}
  end
end
