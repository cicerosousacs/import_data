class SearchHistory < ApplicationRecord
  HistoryObj = Struct.new(:id, :date_history, :name_history, :filters, :filters_params)

  def self.save_history(params)
    count_history = SearchHistory.count
    history = SearchHistory.new
    history.type_history = params[:query]
    history.date_history = Time.now
    history.name_history = "Prospecção Nº #{count_history + 1}"
    history.filters = params.to_json
    history.user_id = ''
    history
  end

  def self.history_list(params)
    history = order('id desc')
    mount_history(history)
  end

  def self.mount_history(history_query)
    filter = []
    history_query.each do |historic|
      data = HistoryObj.new
      data.id = historic.id
      data.date_history = (historic.date_history - (3 * 60 * 60)).strftime("%d/%m/%Y às %H:%M:%S")
      data.name_history = historic.name_history
      data.filters = mount_filter(historic.filters)
      data.filters_params = historic.filters
      filter << data
    end
    filter
  end

  def self.mount_filter(filter)
    fil = JSON.parse(filter)
  
    # Remove os pares chave-valor em que o valor é nulo
    fil.reject! { |key, value| value.nil? || value.empty? || key == "query" }
    
    # Mapeia os nomes das chaves para os nomes desejados
    nome_das_chaves = {
      "company_size_cod" => "Tipo de Empresa",
      "primary_cnae_code" => "Codígo CNAE Primário",
      "uf" => "UF",
      "county_code" => "Cidade",
      "district" => "Bairro",
      "ddd" => "DDD",
      "simple_option" => "Optante do Simples",
      "mei_option" => "Optante do MEI",
      "email" => "E-mail",
      "initial_date" => "Data Início",
      "end_date" => "Data Final",
      "initial_share_capital" => "Capital Social Inicial",
      "end_share_capital" => "Capital Social Final"
    }
    
    # Cria a string com os valores não nulos
    string = fil.map { |key, value| "#{nome_das_chaves[key]}: #{format_value(key, value)}" }.join(", ")
  
    string
  end

  def self.format_value(key, value)
    case key
    when 'primary_cnae_code'
      value.gsub(/,/, ', ')
    when 'county_code'
      County.find_by_code(value).description
    when *%w[simple_option mei_option email]
      value == 'S' ? 'Sim' : 'Não'
    else
      value
    end
  end
end
