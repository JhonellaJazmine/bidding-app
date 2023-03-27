class Bidding < ApplicationRecord

    belongs_to :user
    belongs_to :product
    validates :bid_amount,
    presence: true, numericality: { greater_than_or_equal_to: :minimum_bid_amount }

    before_create :update_current_lowest_bid

    def minimum_bid_amount
      product.current_lowest_bid + product.lowest_allowable_bid
    end

 
    private

  def update_current_lowest_bid
    puts "update_current_lowest_bid method called"
    if bid_amount >= product.current_lowest_bid + product.lowest_allowable_bid
      product.update(current_lowest_bid: bid_amount)
      product.reload.current_lowest_bid
    end
  end
end
