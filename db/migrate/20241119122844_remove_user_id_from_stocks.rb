class RemoveUserIdFromStocks < ActiveRecord::Migration[7.2]
  def change
    remove_column :stocks, :user_id, :integer
  end
end
