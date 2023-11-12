class Company < ApplicationRecord
  belongs_to :legal_nature, optional: true
  belongs_to :company_size, optional: true
end
