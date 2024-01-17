class CreateEstablishments < ActiveRecord::Migration[7.0]
  def change
    create_table :establishments do |t|
      t.string :cnpj_basic
      t.string :cnpj_orde
      t.string :cnpj_dv
      t.string :identifier_office_branch
      t.string :fantasy_name
      t.references :registration_situation, null: false, foreign_key: true
      t.string :date_status_registration
      t.references :registration_status, null: false, foreign_key: true
      t.string :city_name_outside
      t.references :nation, null: false, foreign_key: true
      t.string :start_date_activity
      t.references :cnae, null: false, foreign_key: true
      t.string :secondary_cnae
      t.string :type_street
      t.string :street
      t.string :number
      t.string :complement
      t.string :district
      t.string :cep
      t.string :uf
      t.references :county, null: false, foreign_key: true
      t.integer :ddd_one
      t.integer :telephone_one
      t.integer :ddd_two
      t.integer :telephone_two
      t.integer :ddd_fax
      t.integer :fax
      t.string :email
      t.string :special_situation
      t.string :date_special_situation

      t.timestamps
    end
  end
end
