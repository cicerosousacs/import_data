class SearchController < ApplicationController
  before_action :search_params, only: :searchuniq

  def search
    check_params(search_params)
    result = VwMineraDados.search(search_params[:type], search_params[:cnpj], search_params[:company_name])
    render json: {data: result}
  rescue StandardError => e
    render_error_response(e, :bad_request)
  rescue ExceptionWithResponse
    render_error_response('Erro ao Minerar Dados', :internal_server_error)
  end

  private

  def search_params
    params.permit(:type, :cnpj, :company_name)
  end

  def check_params(params)
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
