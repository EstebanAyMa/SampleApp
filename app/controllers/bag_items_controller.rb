class BagItemsController < ApplicationController
  before_action :set_shopping_bag, only: :create

  def create
    cruise = Cruise.find(params[:cruise_id])
    bag_item = @shopping_bag.add_cruise(cruise, bag_item_params)
    if bag_item.quantity > cruise.quantity
      flash[:danger] = "No hay suficientes camarotes disponibles en el crucero."
    else
      if bag_item.save
        flash[:success] = "Crucero agregado a la reservacion."
      else
        flash[:danger] = "Error al agregar el crucero."
      end
    end
    redirect_to cruise
  end

  def update
    @bag_item = BagItem.find(params[:id])
    if params[:bag_item][:quantity].to_i > @bag_item.cruise.quantity
      flash[:danger] = "No hay suficientes camarotes disponibles en el crucero"
    else
      if @bag_item.update_attributes(bag_item_params)
        flash[:success] = "Los camarotes han sido actualizadas en la reservacion."
      else
        flash[:danger] = "Error al actualizar el numero de camarotes en la reservacion."
      end
    end
    redirect_to shopping_bag_url
  end

  def destroy
    item = BagItem.find(params[:id])
    if item.destroy
      flash[:success] = "El crucero ha sido eliminado de la reservacion."
    else
      flash[:danger] = "Error al eliminar el crucero en la reservacion."
    end
    redirect_to shopping_bag_url
  end

  private

  def bag_item_params
    params.require(:bag_item).permit(:quantity)
  end
end
