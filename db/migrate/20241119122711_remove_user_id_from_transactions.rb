class RemoveUserIdFromTransactions < ActiveRecord::Migration[7.2]
  def change
    remove_column :transactions, :user_id, :integer
  end
end
