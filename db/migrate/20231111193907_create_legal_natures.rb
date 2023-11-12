class CreateLegalNatures < ActiveRecord::Migration[7.0]
  def change
    create_table :legal_natures do |t|
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end
