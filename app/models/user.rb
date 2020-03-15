class User < ActiveRecord::Base
  has_secure_password
  validates :email, uniqueness: true
  validates :email, presence: true
  has_many :garages
  has_many :cars
end
