class RegistrationSituationController < ApplicationController
  def index
    render json: {data: RegistrationSituation.list_cnaes}
  end
end
