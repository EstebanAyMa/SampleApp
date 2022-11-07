class ReservationItem < ApplicationRecord
  belongs_to :reservation
  belongs_to :cruise
  validates :quantity, presence: true, numericality: { only_integer: true }
end
