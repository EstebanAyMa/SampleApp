class ShoppingBagsController < ApplicationController
  before_action :set_shopping_bag, only: :show

  def show
    @bag_items = @shopping_bag.bag_items
    @reservation     = Reservation.new
    unless @shopping_bag.enough_stock?
      msg  = "Lo sentimos, uno o mas productos no se encuentran en almacen. "
      msg += "Por favor, actualice o elimine los productos marcados en rojo."
      flash.now[:danger] = msg
    end
  end
end
