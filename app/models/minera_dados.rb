class MineraDados < ApplicationRecord
  self.table_name = "scm_minera_dados.vw_minera_dados"
  self.primary_key = 'id'

  def self.searchuniq(cnpj, company_name)
    query = all#.order(created_at: :desc)

    query = query.where('LOWER(cnpj) ILIKE ?', "%#{cnpj}%") if cnpj.present?
    query = query.where('LOWER(fantasy_name) ILIKE ?', "%#{company_name}%") if company_name.present?

    query
  end
end