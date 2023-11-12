class ImportController < ApplicationController
  def index_type_tables
  end

  def index_main_tables
  end

  def type_tables  
    handle_import(params[:types], :import_nation, :import_county, :import_legal_nature, :import_qualifications_partners, :import_registration_status, :import_cnaes)
  end

  def main_tables
    handle_import(params[:main_tables], :import_company, :import_establishments, :import_simple_data, :import_partners)
  end

  private

  def handle_import(param, *methods)
    import_type = params['action'] == 'main_tables' ? 'main_tables' : 'type_tables'
    redirect_path = send("import_index_#{import_type}_path")
  
    return redirect_to redirect_path, alert: 'Nenhum arquivo selecionado' unless params[:file]
    return redirect_to redirect_path, alert: 'O arquivo enviado não é um CSV' unless params[:file].content_type == 'text/csv'

    csv_import_service = CsvImportService.new(params[:file])

    selected_method = methods[param.to_i - 1]

    if selected_method
      csv_import_service.send(selected_method)
      redirect_to root_path, notice: "Um total de #{csv_import_service.number_imported_with_last_run} registros foram importados!"
    else
      redirect_to root_path, alert: 'Tipo de tabela não definido'
    end
  end

  def import_params
    params.permit!(:types, :file)
  end
end
