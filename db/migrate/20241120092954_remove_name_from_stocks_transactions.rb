class RemoveNameFromStocksTransactions < ActiveRecord::Migration[7.2]
  def change
    remove_column :stocks, :name, :string
    remove_column :transactions, :name, :string
  end
end
