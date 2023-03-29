class Product < ApplicationRecord
    before_save :check_bidding_expiration
    # before_save :set_current_lowest_bid
    after_create :set_initial_current_lowest_bid

    validates :image, content_type: { in:
    %w(.jpeg .png .jpg), message: 'must be in JPG, JPEG, or PNG format'}
  def set_initial_current_lowest_bid
    self.current_lowest_bid = self.starting_bid_price
    self.save
  end

    belongs_to :user
    has_many :biddings
    validates :name, :description, :image, :lowest_allowable_bid, :starting_bid_price, :bidding_expiration, 
    presence: true
    has_one_attached :image


    validate :validate_bidding_allowed

    def validate_bidding_allowed
      if bidding_allowed && bidding_expiration && bidding_expiration <= Time.current
        errors.add(:bidding_allowed,"cannot be set. Bidding Expiration must be ahead of the Current Time.")
      end
    end


    def update_current_lowest_bid(bid_amount)
        puts "updating"
        if current_lowest_bid.nil? || bid_amount > current_lowest_bid + lowest_allowable_bid
            puts "updating"
            self.current_lowest_bid = bid_amount
          save
        end
      end

      def winner
        if self.bidding_allowed
          # return nil if bidding is still allowed
          return nil
        else
          # find the user who made the highest bid
          highest_bid = Bidding.where(product_id: self.id).maximum(:bid_amount)
          winner = Bidding.find_by(product_id: self.id, bid_amount: highest_bid)
          return winner
        end
      end










    private
    # CALLBACK METHOD FOR CHECKING BIDDING EXPIRATION
    def check_bidding_expiration
        if self.bidding_expiration < Time.current
          self.bidding_allowed = false
        end
    end

  
end
