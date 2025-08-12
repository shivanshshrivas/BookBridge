class UpdateTransactionsReferences < ActiveRecord::Migration[8.0]
  def change
    remove_column :transactions, :lender_id, :bigint
    remove_column :transactions, :borrower_id, :bigint

    add_reference :transactions, :lender, foreign_key: {to_table: :users}, null: false
    add_reference :transactions, :borrower, foreign_key: {to_table: :users}, null: false
  end
end
