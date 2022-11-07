class Region < ApplicationRecord
  has_many :destinations, dependent: :destroy
  has_many :cruises, dependent: :destroy
  validates :name, presence: true

  def display_name
    name.capitalize
  end
end
