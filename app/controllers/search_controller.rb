class SearchController < ApplicationController
  before_action :search_uniq_params, only: :search_uniq
  before_action :search_all_params, only: :search_all

  def search_uniq
    check_search_uniq_params(search_uniq_params)
    result = VwMineraDados.searchuniq(search_uniq_params)
    render json: {data: result}
  rescue StandardError => e
    render_error_response(e, :bad_request)
  rescue ExceptionWithResponse
    render_error_response('Erro ao Minerar Dados', :internal_server_error)
  end

  def search_all
    params = remove_undefine_params(search_all_params)
    check_search_all_params(params)
    result = VwMineraDados.search_all(params)
    render json: {data: result}
  rescue StandardError => e
    render_error_response(e, :bad_request)
  rescue ExceptionWithResponse
    render_error_response('Erro ao Minerar Dados', :internal_server_error)
  end

  private

  def search_uniq_params
    params.permit(:cnpj, :fantasy_name, :company_name)
  end

  def search_all_params
    params.permit(:company_size_code, :registration_situation_code, :primary_cnae_code, :uf, :county_code, :district, :ddd, :simple_option, :mei_option, :email, :initial_date, :end_date)
  end

  def check_search_uniq_params(params)
    unless params[:cnpj].present? || params[:fantasy_name].present? || params[:company_name].present?
      raise 'Informe pelo menos um dos seguintes campos: CNPJ, Nome Fantasia ou Razão Social'
    end
  end

  def remove_undefine_params(params)
    keys_to_check = %i[company_size_code registration_situation_code primary_cnae_code uf county_code district ddd simple_option mei_option email initial_date end_date]
  
    sanitized_params = {}
  
    keys_to_check.each do |key|
      sanitized_params[key] = params[key] == "undefined" || params[key] == "null" ? '' : params[key]
    end
  
    return sanitized_params
  end

  def check_search_all_params(params)
    required_params = [:company_size_code, :registration_situation_code, :primary_cnae_code, :uf, :county_code, :district, :ddd, :simple_option, :mei_option, :email, :initial_date, :end_date]
  
    if required_params.none? { |param| params[param].present? }
      raise 'Informe pelo menos um campo para consulta'
    end
  end

  def render_error_response(message, status)
    render json: { message: message }, status: status
  end
end
