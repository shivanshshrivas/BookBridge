class AddNotNullConstraintsToListings < ActiveRecord::Migration[8.0]
  def change
    change_column_null :listings, :title, false
    change_column_null :listings, :authors, false
    change_column_null :listings, :description, false
    change_column_null :listings, :listing_type, false
    change_column_null :listings, :university, false
  end
end
