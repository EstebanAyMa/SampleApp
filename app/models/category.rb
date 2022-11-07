class Category < ApplicationRecord
  has_many :sub_categories, dependent: :destroy
  has_many :cruises, dependent: :destroy
  validates :name, presence: true

  def display_name
    name.capitalize
  end
end
