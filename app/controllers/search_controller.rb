class SearchController < ApplicationController
  before_action :search_uniq_params, only: :searchuniq

  def searchuniq
    check_search_uniq_params(search_uniq_params)
    result = VwMineraDados.searchuniq(search_uniq_params[:cnpj], search_uniq_params[:company_name])
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

  def check_search_uniq_params(params)
    case params[:type]
    when 'search_uniq'
      raise 'Informe um CNPJ e/ou um Nome Fantasia/Razão Social' if params.blank?
    when 'search_all'
      
    else
      'Parametro invalido'
    end
  end

  def render_error_response(message, status)
    render json: { message: message }, status: status
  end
end
