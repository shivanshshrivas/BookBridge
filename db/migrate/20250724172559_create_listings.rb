class CreateListings < ActiveRecord::Migration[8.0]
  def change
    create_table :listings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :isbn
      t.string :title
      t.string :authors
      t.string :edition
      t.string :course_number
      t.text :description
      t.string :listing_type
      t.float :price
      t.string :status, default: "available"
      t.string :university

      t.timestamps
    end
  end
end
