class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :listing, null: false, foreign_key: true
      t.bigint :lender_id
      t.bigint :borrower_id
      t.date :start_date
      t.date :end_date
      t.integer :status

      t.timestamps
    end
    add_foreign_key :transactions, :users, column: :lender_id
    add_foreign_key :transactions, :users, column: :borrower_id
    add_index :transactions, [:listing_id, :lender_id, :borrower_id, :status], name: "idx_txn_parties"
  end
end
