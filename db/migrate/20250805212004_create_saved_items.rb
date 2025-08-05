class CreateSavedItems < ActiveRecord::Migration[8.0]
  def change
    create_table :saved_items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :listing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
