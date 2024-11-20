class AddForeignKey < ActiveRecord::Migration[7.2]
  def change
    change_column :stocks, :user_id, :bigint
    change_column :transactions, :user_id, :bigint
    
    add_foreign_key :stocks, :users, column: :user_id
    add_foreign_key :transactions, :users, column: :user_id

    add_index :stocks, :user_id
    add_index :transactions, :user_id
  end
end

