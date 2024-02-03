class Cnae < ApplicationRecord
  def self.list_cnaes
    list = []
    all.each do |c|
      list.push({value: c.code, label: c.description})
      # list.push({value: c.code, label: "#{c.code} - #{c.description}"})
    end

    return list
  end
end
