class RegistrationSituation < ApplicationRecord
  def self.list_cnaes
    list = []
    all.each do |c|
      list.push({label: c.description, value: c.code})
    end

    return list
  end
end
