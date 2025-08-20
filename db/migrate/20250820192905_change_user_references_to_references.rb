class ChangeUserReferencesToReferences < ActiveRecord::Migration[8.0]
  def change
    # Transactions table
    remove_column :transactions, :lender_id, :bigint
    remove_column :transactions, :borrower_id, :bigint
    add_reference :transactions, :lender, null: true, foreign_key: {to_table: :users}
    add_reference :transactions, :borrower, null: true, foreign_key: {to_table: :users}

    # Messages table
    remove_column :messages, :sender_id, :bigint
    remove_column :messages, :receiver_id, :bigint
    add_reference :messages, :sender, null: true, foreign_key: {to_table: :users}
    add_reference :messages, :receiver, null: true, foreign_key: {to_table: :users}
  end
end
