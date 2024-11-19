class CreateStocks < ActiveRecord::Migration[7.2]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :name
      t.integer :price
      t.integer :inventory
      t.integer :user_id

      t.timestamps
    end
  end
end
