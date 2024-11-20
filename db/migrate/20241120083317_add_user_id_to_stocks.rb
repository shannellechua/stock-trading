class AddUserIdToStocks < ActiveRecord::Migration[7.2]
  def change
    add_column :stocks, :user_id, :integer
  end
end
