class RemoveNameFromTransactions < ActiveRecord::Migration[7.2]
  def change
    remove_column :transactions, :name, :string
  end
end
