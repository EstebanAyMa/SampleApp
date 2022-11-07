class CruisesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy]
  before_action :get_categories, only: [:new, :create, :edit, :update]

  def index
    respond_to do |format|
      format.html {
        if params[:category]
          category = Category.find(params[:category])
          @cruises = category.cruises.where("quantity > ?", "0").paginate(page: params[:page], per_page: 28)
          @title = category.display_name
        else
          @cruises = Cruise.where("quantity > ?", "0").paginate(page: params[:page], per_page: 28)
          @title = "Todos los cruiseos"
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
    @sub_cats = []
    handle_ajax
  end

  def create
    @cruise = Cruise.new(cruise_params)
    if @cruise.save
      flash[:success] = "El cruiseo ha sido agregado."
      redirect_to @cruise
    else
      get_sub_categories
      render 'new'
    end
  end

  def edit
    @cruise = Cruise.find(params[:id])
    get_sub_categories
    handle_ajax
  end

  def update
    @cruise = Cruise.find(params[:id])
    if @cruise.update_attributes(cruise_params)
      flash[:success] = "El cruiseo ha sido actualizado."
      redirect_to @cruise
    else
      get_sub_categories
      render 'edit'
    end
  end

  def destroy
    if Cruise.find(params[:id]).delete
      flash[:success] = "El cruiseo ha sido eliminado"
    else
      flash[:danger] = "Error al elimiar el cruiseo."
    end
    redirect_to cruises_url
  end

  private

  def cruise_params
    params.require(:cruise).permit(:category_id, :sub_category_id,
                                    :name, :description, :price, :quantity,
                                    :primary_img, {other_imgs: []})
  end

  def get_categories
    @categories = Category.all
  end

  def get_sub_categories
    @sub_cats = []
    unless @cruise.category_id.blank?
      @sub_cats = @cruise.category.sub_categories
    end
  end

  def handle_ajax
    if params[:category].present?
      @sub_cats = Category.find(params[:category]).sub_categories
    end
    if request.xhr?
      respond_to do |format|
        format.json {
          render json: {sub_categories: @sub_cats}
        }
      end
    end
  end
end
