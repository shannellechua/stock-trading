class AddUserIdToTransactions < ActiveRecord::Migration[7.2]
  def change
    add_column :transactions, :user_id, :integer
  end
end
