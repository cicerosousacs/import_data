class CreateCompanySizes < ActiveRecord::Migration[7.0]
  def change
    create_table :company_sizes do |t|
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end
