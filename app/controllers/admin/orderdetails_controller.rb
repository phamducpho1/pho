class Admin::OrderdetailsController < ApplicationController
  before_action :load_orderdetail, only: %i(edit update show)
  load_and_authorize_resource

  def show
    @order_details = OrderDetail.find_order params[:id]
    @orders = Order.all
  end

  private

  def load_orderdetail
    @orderdetail = OrderDetail.find_order params[:id]
    return if @orderdetail
    flash[:warning] = redirect_to "users_controller.errorss"
    redirect_to admin_orderdetail_path
  end
end
