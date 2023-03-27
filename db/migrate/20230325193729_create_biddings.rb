class CreateBiddings < ActiveRecord::Migration[7.0]
  def change
    create_table :biddings do |t|
      t.integer :product_id
      t.integer :user_id
      t.integer :bid_amount
      t.timestamps
    end
  end
end
