class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.string :type
      t.string :symbol
      t.integer :quantity
      t.integer :price
      t.integer :total

      t.timestamps
    end
  end
end
