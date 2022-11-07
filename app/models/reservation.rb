class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :shipping_address, class_name: "Address"
  belongs_to :billing_address,  class_name: "Address"
  has_many :reservation_items

  default_scope -> { order(id: :desc) }

  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :billing_address

  validates :user_id, presence: true
  validates :status, presence: true
end
