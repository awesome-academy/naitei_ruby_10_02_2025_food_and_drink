class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :sender_id
      t.references :chat, null: false, foreign_key: true
      t.timestamps
    end
  end
end
