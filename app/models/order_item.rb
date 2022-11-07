class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :cruise
  validates :quantity, presence: true, numericality: { only_integer: true }
end
