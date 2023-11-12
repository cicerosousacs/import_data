class CreatePartners < ActiveRecord::Migration[7.0]
  def change
    create_table :partners do |t|
      t.string :cnpj_basic
      t.references :partner_type, null: false, foreign_key: true
      t.string :name_partner
      t.string :document_partner
      t.references :qualification_partner, null: false, foreign_key: true
      t.string :date_entry_company
      t.references :nation, null: false, foreign_key: true
      t.string :name_legal_representative
      t.string :document_legal_representative
      t.string :qualification_legal_representative
      t.references :age_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
