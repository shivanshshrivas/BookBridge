class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :lender, null: false, foreign_key: { to_table: :users }
      t.references :borrower, null: false, foreign_key: { to_table: :users }
      t.date :start_date
      t.date :end_date
      t.integer :status

      t.timestamps
    end
  end
end
