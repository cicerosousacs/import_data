class Establishment < ApplicationRecord
  belongs_to :registration_situation
  belongs_to :registration_status
  belongs_to :nation
  belongs_to :cnae
  belongs_to :county
end
