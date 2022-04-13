class Subscription < ApplicationRecord
  belongs_to :user
  has_many :tea_subscriptions
  has_many :teas, through: :tea_subscriptions

  validates :title, :price, :status, :frequency, presence: true
end
