class User < ApplicationRecord
  has_many :subscriptions

  validates :first_name, :last_name, :address, :email, presence: true
end
