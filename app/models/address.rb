class Address < ApplicationRecord
  belongs_to :user
  validates :user_id,  presence: true
  validates :line_1,   presence: true
  validates :town,     presence: true
  validates :county,   presence: true
  validates :postcode, presence: true
end
