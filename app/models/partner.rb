class Partner < ApplicationRecord
  belongs_to :partner_type, optional: true
  belongs_to :qualification_partner, optional: true
  belongs_to :nation, optional: true
  belongs_to :age_group, optional: true
end
