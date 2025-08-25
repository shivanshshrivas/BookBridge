class CreateTextMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :text_messages do |t|
      t.text :content

      t.timestamps
    end
  end
end
