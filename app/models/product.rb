class Product < ApplicationRecord
    before_save :check_bidding_expiration
    # before_save :set_current_lowest_bid
    after_create :set_initial_current_lowest_bid

  def set_initial_current_lowest_bid
    self.current_lowest_bid = self.starting_bid_price
    self.save
  end

    belongs_to :user
    has_many :biddings
    validates :name, :description, :image, :lowest_allowable_bid, :starting_bid_price, :bidding_expiration, 
    presence: true
    has_one_attached :image


    def update_current_lowest_bid(bid_amount)
        puts "updating"
        if current_lowest_bid.nil? || bid_amount > current_lowest_bid + lowest_allowable_bid
            puts "updating"
            self.current_lowest_bid = bid_amount
          save
        end
      end

# CALLBACK METHOD FOR SETTING CURRENT LOWEST BID SAME TO THE STARTING BID





    private
    # CALLBACK METHOD FOR CHECKING BIDDING EXPIRATION
    def check_bidding_expiration
        if self.bidding_expiration < Time.current
          self.bidding_allowed = false
        end
    end

  
end
