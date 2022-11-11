class CruisesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy]
  before_action :regions, only: [:new, :create, :edit, :update]

  def index
    respond_to do |format|
      format.html {
        if params[:region]
          region = Region.find(params[:region])
          @cruises = region.cruises.where("quantity > ?", "0").paginate(page: params[:page], per_page: 28)
          @title = region.display_name
        else
          @cruises = Cruise.where("quantity > ?", "0").paginate(page: params[:page], per_page: 28)
          @title = "Todos los cruceros"
        end
      }
      format.json { render json: Cruise.paginate(page: params[:page], per_page: params[:per_page]) }
    end
  end

  def show
    @cruise = Cruise.find(params[:id])
    respond_to do |format|
      format.html { @bag_item = BagItem.new }
      format.json { render json: @cruise }
    end
  end

  def new
    @cruise = Cruise.new
    @destinations = []
    handle_ajax
  end

  def create
    @cruise = Cruise.new(cruise_params)
    if @cruise.save
      flash[:success] = "El crusero ha sido agregado."
      redirect_to @cruise
    else
      destinations
      render 'new'
    end
  end

  def edit
    @cruise = Cruise.find(params[:id])
    destinations
    handle_ajax
  end

  def update
    @cruise = Cruise.find(params[:id])
    if @cruise.update(cruise_params)
      flash[:success] = "El crusero ha sido actualizado."
      redirect_to @cruise
    else
      destinations
      render 'edit'
    end
  end

  def destroy
    if Cruise.find(params[:id]).delete
      flash[:success] = "El cruisero ha sido eliminado"
    else
      flash[:danger] = "Error al elimiar el cruisero."
    end
    redirect_to cruises_url
  end

  private

  def cruise_params
    params.require(:cruise).permit(:region_id, :destination_id,
                                    :name, :description, :price, :quantity,
                                    :primary_img, {other_imgs: []})
  end

  def regions
    @regions ||= Region.all
  end

  def destinations
    @destinations ||= @cruise.region_id.present? ? @cruise.region.destinations : []
  end

  def handle_ajax
    @destinations = Region.find(params[:region_id]).destinations if params[:region_id].present?
    if params[:region_id].present?
      respond_to do |format|
        format.json { render json: { destinations: @destinations } }
      end
    end
  end
end
