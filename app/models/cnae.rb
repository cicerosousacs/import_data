class Cnae < ApplicationRecord
  def self.list_cnaes
    list = []
    all.each do |c|
      list.push({value: c.code, label: c.description})
    end

    return list
  end
end
