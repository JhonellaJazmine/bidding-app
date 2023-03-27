class User < ApplicationRecord
  has_secure_password
  enum role: [:bidder, :auctioneer]
  has_many :products
  has_many :biddings
end
