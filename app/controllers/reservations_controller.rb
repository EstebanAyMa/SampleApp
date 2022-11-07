class ReservationsController < ApplicationController
  before_action :set_shopping_bag, only: [:new, :create, :summary, :payment]
  before_action :logged_in_user
  before_action :admin_user, only: [:index, :update]
  before_action :correct_user, only: :show
  before_action :get_previous_addresses, only: [:new, :create]

  def index
    @reservations = Reservation.where("status >= ?", "1").paginate(page: params[:page])
  end

  def order_history
    @reservations = current_user.reservations.where("status >= ?", "1").paginate(page: params[:page])
  end

  def show
    @reservation = Reservation.find(params[:id])
    redirect_to root_url if @reservation.status == 0
  end

  def new
    if @shopping_bag.bag_items.any?
      order_in_progress = current_user.reservations.where(status: 0).first
      if order_in_progress
        redirect_to reservation_summary_url(order_in_progress)
      else
        @reservation = Reservation.new
        @reservation.shipping_address = Address.new
        @reservation.billing_address  = Address.new
      end
    else
      redirect_to root_url
    end
  end

  def create
    @reservation = current_user.reservations.build(order_params)
    @reservation.shipping_address_id = params[:reservation][:shipping_address_id].to_i if params[:reservation][:shipping_address_id]
    if params[:same_billing_address] == '1'
      @reservation.billing_address = @reservation.shipping_address
    else
       @reservation.billing_address_id = params[:reservation][:billing_address_id].to_i if params[:reservation][:billing_address_id]
    end
    if @reservation.save
      redirect_to reservation_summary_url(@reservation)
    else
      render 'new'
    end
  end

  def summary
    @reservation = Reservation.find(params[:id])
    redirect_to root_url if @reservation.status > 0
  end

  def payment
    order = Reservation.find(params[:id])
    order.update_attributes(item_total: @shopping_bag.total,
                            postage: @shopping_bag.calculate_postage,
                            status: 1)
    @shopping_bag.bag_items.each do |item|
      order.order_items.create(cruise: item.cruise, quantity: item.quantity)
      item.cruise.update_stock(item.quantity)
      item.destroy
    end
    respond_to do |format|
      format.html { redirect_to reservation_confirmation_url(order) }
      format.js
    end
  end

  def confirmation
    @reservation = Reservation.find(params[:id])
    redirect_to root_url if @reservation.status != 1
    UserMailer.reservation_confirmation(current_user).deliver_now
    AdminMailer.new_order.deliver_now
    @reservation.update_attributes(status: 2)
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.update_attributes(status: 3)
    UserMailer.reservation_booked(@reservation.user).deliver_now
    respond_to do |format|
      format.html { redirect_to reservations_url }
      format.js
    end
  end

  private

  def order_params
    params.require(:reservation).permit(
      shipping_address_attributes: [ :user_id, :line_1, :line_2, :line_3,
                                     :town, :county, :postcode ],
      billing_address_attributes:  [ :user_id, :line_1, :line_2, :line_3,
                                     :town, :county, :postcode ]
    )
  end

  def correct_user
    order = Reservation.find(params[:id])
    redirect_to root_url unless current_user?(order.user) || current_user.admin?
  end

  def get_previous_addresses
   @shipping_addresses = current_user.reservations.unscope(:reservation)
                                     .distinct.select(:shipping_address_id)
                                     .map { |x| x.shipping_address }
   @billing_addresses  = current_user.reservations.unscope(:reservation)
                                     .distinct.select(:billing_address_id)
                                     .map { |x| x.billing_address }
  end
end
