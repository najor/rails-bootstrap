# Order
class Order < ActiveRecord::Base
  belongs_to :product
  belongs_to :customer

  enum status: [:draft, :confirmed, :canceled]

  validates :customer, presence: true
end
