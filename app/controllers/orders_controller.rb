class OrdersController < ApplicationController
  before_action :logged_in_user, only: :new

  def new
    @oder = Order.new
    @cart = current_cart
    @total = @cart.total_price
    @user = current_user.id
  end

  def show
    @order = Order.find_order session[:user_id]
    return if @order
    flash[:error] = t "user.show.notfind"
    redirect_to root_url
  end

  def create
    @oder = Order.new order_params
    if @oder.save
      # UserMailer.mailer_order(@oder).deliver_now
      UserJob.perform_later(@oder)
      create_order
      destroy_session session[:cart_id]
      session[:cart_id] = nil
      redirect_to root_url
    else
      render :new
    end
  end

  def order_params
    params.require(:order).permit(:total_amount, :user_id, :phone, :address)
  end

  private

  def create_order
    @item = current_cart.line_items
    ActiveRecord::Base.transaction do
      @item.each do |cate|
        OrderDetail.create!(order_id: @oder.id, product_id: cate.product_id, quanlity: cate.quantity)
        update_product cate
      end
    end
    flash[:success] = t "orders_controller.create"
  rescue
    flash[:error] = t "orders_controller.errror"
  end

  def update_product cate
    @product = Product.find_by id: cate.product_id
    @product.update_attributes! quanlity: (@product.quanlity - cate.quantity) if @product
  end
end
