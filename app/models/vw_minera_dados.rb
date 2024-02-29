require 'will_paginate/array'
class VwMineraDados < ApplicationRecord
  self.table_name = 'scm_minera_dados.vw_minera_dados'
  self.primary_key = 'id'

  Query_Obj = Struct.new(
    :cnpj, :identification, :fantasy_name, :registration_situation, :date_status_registration, :reason_registration_status, :city_name_outside,
    :nation, :start_date_activity, :primary_cnae, :secondary_cnae, :address, :uf, :cep, :telephone_one, :telephone_two, :fax, :email, :special_situation, 
    :date_special_situation, :simple_option, :date_option_simple, :date_exclusion_simple, :opting_for_mei, :mei_option_date, :date_exclusion_mei, 
    :partners, :name_company, :legal_nature, :qualification_responsible, :share_capital, :company_size, :federative_entity_responsible
  )

  def self.search_uniq(params)
    query = all

    query = query.where(cnpj: params[:cnpj]) if params[:cnpj].present?
    query = query.where(name_company: params[:company_name]) if params[:company_name].present?
    query = query.where('LOWER(fantasy_name) ILIKE ?', "%#{params[:fantasy_name]}%") if params[:fantasy_name].present?

    mount_result(query)
  end

  def self.search_all(params)
    query = all

    array = params[:primary_cnae_code].split(',')
    cnaes_codes = array.map { |element| "'#{element}'" }.join(", ")

    initial_date = params[:initial_date].gsub('-', '').presence || params[:end_date].gsub('-', '')
    end_date = params[:end_date].gsub('-', '').presence || params[:initial_date].gsub('-', '')

    initial_share_capital = params[:initial_share_capital].presence || params[:end_share_capital]
    end_share_capital = params[:end_share_capital].presence || params[:initial_share_capital]

    query = query.where('LOWER(cnpj) ILIKE ?', "%#{params[:cnpj]}%") if params[:cnpj].present?
    query = query.where('LOWER(fantasy_name) ILIKE ?', "%#{params[:fantasy_name]}%") if params[:fantasy_name].present?
    query = query.where('LOWER(name_company) ILIKE ?', "%#{params[:company_name]}%") if params[:company_name].present?

    # query = query.where('LOWER(share_capital) => ?', "#{params[:initial_share_capital]}") if params[:share_capital].present?
    query = query.where(share_capital: initial_share_capital..end_share_capital) if params[:initial_share_capital].present? || params[:end_share_capital].present?
    query = query.where(company_size_code: params[:company_size_code]) if params[:company_size_code].present?
    # query = query.where(registration_situation_code: params[:registration_situation_code]) if params[:registration_situation_code].present?
    query = query.where("primary_cnae_code IN (#{cnaes_codes})") if params[:primary_cnae_code].present?
    query = query.where(uf: params[:uf]) if params[:uf].present?
    query = query.where(county_code: params[:county_code]) if params[:county_code].present?
    query = query.where(district: params[:district]) if params[:district].present?
    query = query.where(ddd_one: params[:ddd]) if params[:ddd].present?
    query = query.where(simple_option: params[:simple_option]) if params[:simple_option].present?
    query = query.where(opting_for_mei: params[:mei_option]) if params[:mei_option].present?
    query = query.where(start_date_activity: initial_date..end_date) if params[:initial_date].present? || params[:end_date].present?
    query = params[:email] == 'N' ? query.where(email: nil) : query.where.not(email: nil) if params[:email].present?

    query = params[:query] == 'SearchAll' ? query.limit(50) : query

    mount_result(query)
  end

  def self.date_range(initial_date, end_date)
    initial_date.present? && end_date.present? ? (initial_date..end_date) : nil
  end

  def self.mount_result(result)
    filter = []
    result.each do |r|
      data = Query_Obj.new
      data.cnpj = r.cnpj
      data.identification = r.identification
      data.fantasy_name = r.fantasy_name
      data.registration_situation = r.registration_situation # description_registration_situation(r.registration_situation_code)
      data.date_status_registration = r.date_status_registration
      data.reason_registration_status = description_reason_registration_status(r.reason_registration_status_code)
      data.city_name_outside = r.city_name_outside
      data.nation = r.nation
      data.start_date_activity = r.start_date_activity
      data.primary_cnae = description_cnae(r.primary_cnae_code)
      data.secondary_cnae = mount_secondary_cnae(r.secondary_cnae_code)
      data.address = mount_address(r)
      data.uf = r.uf
      data.cep = r.cep
      data.telephone_one = mount_telephone(r.ddd_one, r.telephone_one)
      data.telephone_two = mount_telephone(r.ddd_two, r.telephone_two)
      data.fax = mount_telephone(r.ddd_fax, r.fax)
      data.email = r.email.present? ? r.email.downcase : ''
      data.special_situation = r.special_situation
      data.date_special_situation = r.date_special_situation
      data.simple_option = r.simple_option
      data.date_option_simple = r.date_option_simple
      data.date_exclusion_simple = r.date_exclusion_simple
      data.opting_for_mei = r.opting_for_mei
      data.mei_option_date = r.mei_option_date
      data.date_exclusion_mei = r.date_exclusion_mei
      data.partners = r.partners
      data.name_company = r.name_company.gsub(/\d/, '').strip
      data.legal_nature = r.legal_nature
      data.qualification_responsible = r.qualification_responsible
      data.share_capital = r.share_capital
      data.company_size = description_company_size(r.company_size_code)
      data.federative_entity_responsible = r.federative_entity_responsible
      filter << data
    end
    filter
  end

  # def self.description_registration_situation(registration_situation_code)
  #   RegistrationSituation.find_by_code(registration_situation_code).description
  # end

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
      secondary_cnae = Cnae.find_by_code(secondary_cnae_code)
      secondary_cnae_description = secondary_cnae.present? ? secondary_cnae.description : 'Atividade Econônica não informada'

      array_string.push(secondary_cnae_description)
    end

    array_string.split(',')
  end

  def self.mount_telephone(ddd, telephone_one)
    "#{ddd}#{telephone_one}"
  end

  def self.mount_address(r)
    county = County.find_by_code(r.county_code).description
    complement = r.complement.present? ? "#{r.complement}, " : ""
    nation = r.nation == 'NAO DECLARADOS' ? "" : r.nation

    "#{r.type_street_name}, nº #{r.number}, #{complement}#{county}. #{r.district}/#{r.uf}. #{nation}"
  end

  # def self.mount_partners(result)
  #   partner_type = result.partner_type
  #   name_partner = result.name_partner
  #   document_partner = result.document_partner
  #   qualification_partner = result.qualification_partner 
  #   date_entry_company = result.date_entry_company
  #   partner_country = result.partner_country
  #   name_legal_representative = result.name_legal_representative
  #   document_legal_representative = result.document_legal_representative
  #   qualification_legal_representative = result.qualification_legal_representative
  #   age_group = result.age_group
  # end

  def self.description_company_size(company_size_code)
    CompanySize.find_by_code(company_size_code).description
  end
end