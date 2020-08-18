class CreateTableConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.references :account
      t.references :friend
      t.date :date
    end
  end
end
