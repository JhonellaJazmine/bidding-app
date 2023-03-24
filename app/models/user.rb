class User < ApplicationRecord
  has_secure_password
  enum role: [:bidder, :auctioneer]
end
