class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items

  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than: 0 }
  validates :stock, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :is_active, inclusion: { in: [true, false] }
  validates :image, presence: true
end