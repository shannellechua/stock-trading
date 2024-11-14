class CreateStocks < ActiveRecord::Migration[7.2]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :name
      t.integer :quantity
      t.integer :current_price
      t.integer :total_value

      t.timestamps
    end
  end
end
