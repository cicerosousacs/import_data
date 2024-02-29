class Establishment < ApplicationRecord
  belongs_to :registration_situation
  belongs_to :registration_status
  belongs_to :nation
  belongs_to :cnae
  belongs_to :county

  def self.municipality_from_uf(uf_id)
    list = []
    
    federal_union = where(uf: uf_id)
    federal_union = federal_union.to_a.uniq! { |uf| uf.county_id }

    federal_union.each do |state|
      list.push({label: state.county.description, value: state.county.code})
    end

    list = list.sort_by { |item| item[:label] }

    return list
  end

  def self.district_from_municipality(county_code)
    list = []

    county_id = County.find_by_code(county_code)
    municipality = where(county_id: county_id)
    municipality = municipality.to_a.uniq { |uf| uf.district }

    municipality.each do |district|
      list.push({label: district.district, value: district.district})
    end

    list = list.sort_by { |item| item[:label] }

    return list
  end
end
