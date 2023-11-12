class CreateRegistrationStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :registration_statuses do |t|
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end
