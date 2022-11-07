class BagItemsController < ApplicationController
  before_action :set_shopping_bag, only: :create

  def create
    product = Product.find(params[:product_id])
    bag_item = @shopping_bag.add_product(product, bag_item_params)
    if bag_item.quantity > product.quantity
      flash[:danger] = "No hay suficientes productos en almacen."
    else
      if bag_item.save
        flash[:success] = "Producto agregado a la orden de compra."
      else
        flash[:danger] = "Error al agregar el producto."
      end
    end
    redirect_to product
  end

  def update
    @bag_item = BagItem.find(params[:id])
    if params[:bag_item][:quantity].to_i > @bag_item.product.quantity
      flash[:danger] = "No hay suficientes productos en almacen"
    else
      if @bag_item.update_attributes(bag_item_params)
        flash[:success] = "La cantidad del producto ha sido actualizada en la orden de compra."
      else
        flash[:danger] = "Error al actualizar la cantidad del producto."
      end
    end
    redirect_to shopping_bag_url
  end

  def destroy
    item = BagItem.find(params[:id])
    if item.destroy
      flash[:success] = "El producto ha sido eliminado de la orden de compra."
    else
      flash[:danger] = "Error al eliminar el producto de la orden de compra."
    end
    redirect_to shopping_bag_url
  end

  private

  def bag_item_params
    params.require(:bag_item).permit(:quantity)
  end
end
