class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :cnpj_basic
      t.string :name_company
      t.references :legal_nature, null: false, foreign_key: true
      t.string :qualification_responsible
      t.string :share_capital
      t.references :company_size, null: false, foreign_key: true
      t.string :federative_entity_responsible

      t.timestamps
    end
  end
end
