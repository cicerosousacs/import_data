class CreateSimples < ActiveRecord::Migration[7.0]
  def change
    create_table :simples do |t|
      t.string :cnpj_basic
      t.string :simple_option
      t.string :date_option_simple
      t.string :date_exclusion_simple
      t.string :opting_for_mei
      t.string :mei_option_date
      t.string :date_exclusion_mei

      t.timestamps
    end
  end
end
