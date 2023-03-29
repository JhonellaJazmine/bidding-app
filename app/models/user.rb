class User < ApplicationRecord
  enum role: [:bidder, :auctioneer]
  has_many :products
  has_many :biddings



  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
/x

  has_secure_password
   validates :password, presence: true, format: { with: PASSWORD_FORMAT, message: 'must contain a digit, a lower case character, and an upper case character '}, length: { minimum: 8 }
end
