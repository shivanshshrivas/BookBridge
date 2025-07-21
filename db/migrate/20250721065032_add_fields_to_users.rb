class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string
    add_column :users, :university, :string
    add_column :users, :profile_bio, :text
  end
end
