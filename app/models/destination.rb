class Destination < ApplicationRecord
  belongs_to :region
  has_many :cruises, dependent: :destroy
  validates :name, presence: true
  validates :region_id, presence: true

  def display_name
    name.capitalize
  end
end
