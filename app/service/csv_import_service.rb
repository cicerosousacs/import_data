class CsvImportService
  require 'csv'

  def initialize(file)
    @file = file
    @count = 0
  end

  def import_county
    import_data(County)
  end

  def import_cnaes
    import_data(Cnae)
  end

  def import_nation
    import_data(Nation)
  end

  def import_legal_nature
    import_data(LegalNature)
  end

  def import_qualifications_partners
    import_data(QualificationPartner)
  end

  def import_registration_status
    import_data(RegistrationStatus)
  end

  def import_company
    @count = 0
    CSV.foreach(@file, col_sep: ',').with_index do |line, index|
      Company.transaction do
        find_or_create_company(line)
        @count += 1
      end
    end
  end

  def import_partners
    @count = 0
    CSV.foreach(@file, col_sep: ',').with_index do |line, index|
      Partner.transaction do
        find_or_create_partner(line)
        @count += 1
      end
    end
  end

  def import_establishments
    @count = 0
    CSV.foreach(@file, col_sep: ',').with_index do |line, index|
      Establishment.transaction do
        find_or_create_establishment(line)
        @count += 1
      end
    end
  end

  def import_simple_data
    @count = 0
    CSV.foreach(@file, col_sep: ',').with_index do |line, index|
      Simple.transaction do
        find_or_create_simple(line)
        @count += 1
      end
    end
  end

  def number_imported_with_last_run
    @count
  end

  private

  def import_data(model_class)
    @count = 0
    CSV.foreach(@file, col_sep: ',').with_index do |line, index|
      model_class.transaction do
        model_class.find_or_create_by!(
          code: line[0],
          description: line[1]
        )
        @count += 1
      end
    end
  end

  def find_or_create_company(line)
    Company.find_or_create_by!(
      cnpj_basic: line[0],
      name_company: line[1],
      legal_nature_id: find_legal_nature_id(line[2]),
      qualification_responsible: line[3],
      share_capital: line[4],
      company_size_id: find_company_size_id(line[5]),
      federative_entity_responsible: line[6]
    )
  end

  def find_or_create_simple(line)
    Simple.find_or_create_by!(
      cnpj_basic: line[0],
      simple_option: line[1],
      date_option_simple: line[2],
      date_exclusion_simple: line[3],
      opting_for_mei: line[4],
      mei_option_date: line[5],
      date_exclusion_mei: line[6],
    )
  end

  def find_or_create_establishment(line)
    Establishment.find_or_create_by!(
      cnpj_basic: line[0],
      cnpj_orde: line[1],
      cnpj_dv: line[2],
      identifier_office_branch: line[3],
      fantasy_name: line[4],
      registration_situation_id: find_registration_situation_id(line[5]),
      date_status_registration: line[6],
      registration_status_id: find_registration_status_id(line[7]),
      city_name_outside: line[8],
      nation_id: find_nation_id(line[9]),
      start_date_activity: line[10],
      cnae_id: find_cnae_id(line[11]),
      secondary_cnae: line[12],
      type_street: line[13],
      street: line[14],
      number: line[15],
      complement: line[16],
      district: line[17],
      cep: line[18],
      uf: line[19],
      county_id: find_county_id(line[20]),
      ddd_one: line[21],
      telephone_one: line[22],
      ddd_two: line[23],
      telephone_two: line[24],
      ddd_fax: line[25],
      fax: line[26],
      email: line[27],
      special_situation: line[28],
      date_special_situation: line[29]
    )
  end

  def find_or_create_partner(line)
    Partner.find_or_create_by!(
      cnpj_basic: line[0],
      partner_type_id: find_partner_type_id(line[1]),
      name_partner: line[2],
      document_partner: line[3],
      qualification_partner_id: find_qualification_partner_id(line[4]),
      date_entry_company: line[5],
      nation_id: find_nation_id(line[6]),
      name_legal_representative: line[7],
      document_legal_representative: line[8],
      qualification_legal_representative: line[9],
      age_group_id: find_age_group_id(line[10]),
    )
  end
  
  def find_partner_type_id(code)
    PartnerType.find_by_code(code).id
  end
  
  def find_qualification_partner_id(code)
    QualificationPartner.find_by_code(code).id
  end
  
  def find_nation_id(code)
    return '253' if code.nil?

    nation = Nation.find_by_code(code)
    nation.nil? ? '253' : nation.id
  end
  
  def find_age_group_id(code)
    AgeGroup.find_by_code(code).id
  end

  def find_legal_nature_id(code)
    LegalNature.find_by_code(code).id
  end

  def find_company_size_id(code)
    CompanySize.find_by_code(code).id
  end

  def find_registration_situation_id(code)
    RegistrationSituation.find_by_code(code).id
  end

  def find_registration_status_id(code)
    RegistrationStatus.find_by_code(code).id
  end

  def find_cnae_id(code)
    Cnae.find_by_code(code).id
  end

  def find_county_id(code)
    # byebug
    return 5572 if code == "RJ" || code == "GO"
    County.find_by_code(code).id
  end
end
