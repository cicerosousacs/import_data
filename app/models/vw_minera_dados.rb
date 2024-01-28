class VwMineraDados < ApplicationRecord
  self.table_name = 'scm_minera_dados.vw_minera_dados'
  self.primary_key = 'id'

  Query_Obj = Struct.new(
    :cnpj, :identification, :fantasy_name, :registration_situation_id, :date_status_registration, :reason_registration_status, :city_name_outside,
    :nation, :start_date_activity, :primary_cnae, :secondary_cnae, :address, :cep, :telephone_one, :telephone_two, :fax, :email, :special_situation, 
    :date_special_situation, :simple_option, :date_option_simple, :date_exclusion_simple, :opting_for_mei, :mei_option_date, :date_exclusion_mei, 
    :partner_type, :name_partner, :document_partner, :qualification_partner, :date_entry_company, :partner_country, :name_legal_representative, 
    :document_legal_representative, :qualification_legal_representative, :age_group, :name_company, :legal_nature, :qualification_responsible, 
    :share_capital, :company_size, :federative_entity_responsible
  )

  def self.search(type, cnpj, company_name)
    query = all#.order(created_at: :desc)

    case type
    when 'search_uniq'
      query = query.where('LOWER(cnpj) ILIKE ?', "%#{cnpj}%") if cnpj.present?
      query = query.where('LOWER(fantasy_name) ILIKE ?', "%#{company_name}%") if company_name.present?
    when 'search_all'
      
    else
      'Não foi possivel realizar a pesquisa'
    end

    mount_result(query)
  end

  def self.mount_result(resut)
    filter = []
    resut.each do |r|
      data = Query_Obj.new
      data.cnpj = r.cnpj
      data.identification = r.identification
      data.fantasy_name = r.fantasy_name
      data.registration_situation_id = description_registration_situation(r.registration_situation_code)
      data.date_status_registration = r.date_status_registration
      data.reason_registration_status = description_reason_registration_status(r.reason_registration_status_code)
      data.city_name_outside = r.city_name_outside
      data.nation = r.nation
      data.start_date_activity = r.start_date_activity
      data.primary_cnae = description_cnae(r.primary_cnae_code)
      data.secondary_cnae = mount_secondary_cnae(r.secondary_cnae_code)
      data.address = mount_address(r)
      data.cep = r.cep
      data.telephone_one = r.telephone_one
      data.telephone_two = r.telephone_two
      data.fax = r.fax
      data.email = r.email.downcase
      data.special_situation = r.special_situation
      data.date_special_situation = r.date_special_situation
      data.simple_option = r.simple_option
      data.date_option_simple = r.date_option_simple
      data.date_exclusion_simple = r.date_exclusion_simple
      data.opting_for_mei = r.opting_for_mei
      data.mei_option_date = r.mei_option_date
      data.date_exclusion_mei = r.date_exclusion_mei
      data.partner_type = r.partner_type
      data.name_partner = r.name_partner
      data.document_partner = r.document_partner
      data.qualification_partner = r.qualification_partner 
      data.date_entry_company = r.date_entry_company
      data.partner_country = r.partner_country
      data.name_legal_representative = r.name_legal_representative
      data.document_legal_representative = r.document_legal_representative
      data.qualification_legal_representative = r.qualification_legal_representative
      data.age_group = r.age_group
      data.name_company = r.name_company
      data.legal_nature = r.legal_nature
      data.qualification_responsible = r.qualification_responsible
      data.share_capital = r.share_capital
      data.company_size = r.company_size
      data.federative_entity_responsible = r.federative_entity_responsible
      filter << data
    end
    filter
  end

  def self.description_registration_situation(registration_situation_code)
    RegistrationSituation.find_by_code(registration_situation_code).description
  end

  def self.description_reason_registration_status(reason_registration_status_code)
    RegistrationStatus.find_by_code(reason_registration_status_code).description
  end

  def self.description_cnae(cnae_code)
    Cnae.find_by_code(cnae_code).description
  end

  def self.mount_secondary_cnae(secondary_cnae_codes)
    array_string = []
    
    return nil if secondary_cnae_codes.blank?

    secondary_cnae_codes.split(',').each do |secondary_cnae_code|
      secondary_cnae_code = secondary_cnae_code.start_with?('0') ? secondary_cnae_code[1..-1] : secondary_cnae_code
      array_string.push(Cnae.find_by_code(secondary_cnae_code).description)
    end

    array_string
  end

  def self.mount_address(r)
    county = County.find_by_code(r.county_code).description
    complement = r.complement.present? ? "#{r.complement}, " : ""
    nation = r.nation == 'NAO DECLARADOS' ? "" : r.nation

    "#{r.type_street_name}, nº #{r.number}, #{complement}#{county}. #{r.district}/#{r.uf}. #{nation}"
  end
end