class ExportController < ApplicationController

  def export_to_xlsx
    params = remove_undefine_params(params_export)
    filename = XlsxService.export_to_xlsx(params)

    send_data File.read("/tmp/#{filename}"), type: "application/xlsx", filename: filename
  end

  private

  def params_export
    params.permit(
      :cnpj, :fantasy_name, :company_name, :company_size_code, :registration_situation_code, :primary_cnae_code, 
      :uf, :county_code, :district, :ddd, :simple_option, :mei_option, :email, :initial_date, :end_date
    )
  end

  def remove_undefine_params(params)
    keys_to_check = %i[cnpj fantasy_name company_name company_size_code registration_situation_code primary_cnae_code uf county_code district ddd simple_option mei_option email initial_date end_date]
  
    sanitized_params = {}
  
    keys_to_check.each do |key|
      sanitized_params[key] = params[key] == "undefined" || params[key] == "null" ? '' : params[key]
    end
  
    return sanitized_params
  end
end
