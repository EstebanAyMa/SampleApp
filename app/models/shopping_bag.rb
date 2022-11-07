class ShoppingBag < ApplicationRecord
  belongs_to :user, optional: true
  has_many :bag_items

  def add_cruise(cruise, params)
    current_item = bag_items.find_by(cruise: cruise)
    if current_item
      current_item.quantity += params[:quantity].to_i
      current_item
    else
      bag_items.build(cruise: cruise, quantity: params[:quantity])
    end
  end

  def total
    price = 0
    bag_items.each do |item|
      price += item.cruise.price * item.quantity
    end
    price
  end

  def calculate_postage
    500
  end

  def enough_stock?
    self.bag_items.each do |item|
      return false if item.cruise.quantity < item.quantity
    end
  end
end
