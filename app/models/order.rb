class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items, dependent: :destroy

  enum status: { pending: 0, paid: 1, shipped: 2, completed: 3 }

  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end