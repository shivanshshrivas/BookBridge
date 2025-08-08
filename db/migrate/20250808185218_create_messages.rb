class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.references :listing, null: false, foreign_key: true
      t.bigint :sender_id
      t.bigint :receiver_id
      t.references :messageable, polymorphic: true, null: false

      t.timestamps
    end
    add_foreign_key :messages, :users, column: :sender_id
    add_foreign_key :messages, :users, column: :receiver_id
    add_index :messages, [:listing_id, :sender_id, :receiver_id, :created_at], name: "idx_messages_thread"
  end
end
