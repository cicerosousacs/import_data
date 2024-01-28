class SearchController < ApplicationController
  before_action :search_uniq_params, only: :searchuniq
  before_action :search_all_params, only: :search_all

  def searchuniq
    check_search_uniq_params(search_uniq_params)
    result = VwMineraDados.searchuniq(search_uniq_params[:cnpj], search_uniq_params[:company_name])
    render json: {data: result}
  rescue StandardError => e
    render_error_response(e, :bad_request)
  rescue ExceptionWithResponse
    render_error_response('Erro ao Minerar Dados', :internal_server_error)
  end

  def search_all
    # check_search_uniq_params(search_uniq_params)
    result = VwMineraDados.searchuniq(search_all_params)
    render json: {data: result}
  rescue StandardError => e
    render_error_response(e, :bad_request)
  rescue ExceptionWithResponse
    render_error_response('Erro ao Minerar Dados', :internal_server_error)
  end

  private

  def search_uniq_params
    params.permit(:type, :cnpj, :company_name)
  end

  def search_all_params
    params.permit(:type, :cnpj, :company_name)
  end

  def check_search_uniq_params(params)
    raise 'Informe um CNPJ e/ou um Nome Fantasia/Razão Social' if params[:cnpj].blank?
  end

  def render_error_response(message, status)
    render json: { message: message }, status: status
  end
end
