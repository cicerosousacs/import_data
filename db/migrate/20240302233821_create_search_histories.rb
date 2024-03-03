class CreateSearchHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :search_histories do |t|
      t.string :type_history
      t.timestamps :date_history
      t.string :name_history
      t.jsonb :filters
      t.integer :user_id

      t.timestamps
    end
  end
end
