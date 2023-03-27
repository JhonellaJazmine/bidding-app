class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.text :name
      t.text :description
      t.integer :lowest_allowable_bid
      t.integer :starting_bid_price
      t.datetime :bidding_expiration
      t.integer :current_lowest_bid
      t.boolean :bidding_allowed, default: true, null: false
      t.integer :user_id
      t.timestamps
    end
  end
end
