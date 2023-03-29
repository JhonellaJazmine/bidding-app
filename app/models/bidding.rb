class Bidding < ApplicationRecord

    belongs_to :user
    belongs_to :product
    validates :bid_amount,
    presence: true

    before_create :update_current_lowest_bid

# FOR CHECKING IF BID_AMOUNT >= CURRENT_LOWEST_BID + LOWEST_ALLOWABLE_BID


validate :minimum_bid_amount

  def minimum_bid_amount
    unless bid_amount && product.current_lowest_bid && product.lowest_allowable_bid
      # errors.add(:bid_amount, "can't be blank")
      return
    end

    min_bid = product.current_lowest_bid + product.lowest_allowable_bid
    if bid_amount < min_bid
      errors.add(:bid_amount, "must be greater than or equal to ₱ #{min_bid}")
    end
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
