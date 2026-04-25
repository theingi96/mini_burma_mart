class Address < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :nullify

  validates :postal_code, presence: true
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :address_line, presence: true
  validates :phone_number, presence: true
end