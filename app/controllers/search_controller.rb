class SearchController < ApplicationController
  before_action :searchuniq_params, only: :searchuniq
  before_action :searchall_params, only: :searchall


  def searchuniq
    result = MineraDados.searchuniq(searchuniq_params[:cnpj], searchuniq_params[:company_name])
    render json: {data: result}
  rescue StandardError => e
    render_error_response(e, :bad_request)
  rescue ExceptionWithResponse
    render_error_response('Erro ao buscar precedentes', :internal_server_error)
  end

  def searchall
  end

  private

  def searchuniq_params
    params.permit(:cnpj, :company_name)
  end

  def searchall_params
  end

  def render_error_response(message, status)
    render json: { message: message }, status: status
  end
end
