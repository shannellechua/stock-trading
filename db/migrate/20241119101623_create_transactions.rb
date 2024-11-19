class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.string :type_of_transaction
      t.string :symbol
      t.string :name
      t.integer :quantity
      t.integer :stock_price
      t.integer :total_price

      t.timestamps
    end
  end
end
