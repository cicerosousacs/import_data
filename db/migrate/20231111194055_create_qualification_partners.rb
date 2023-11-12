class CreateQualificationPartners < ActiveRecord::Migration[7.0]
  def change
    create_table :qualification_partners do |t|
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end
