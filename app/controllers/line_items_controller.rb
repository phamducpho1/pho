class LineItemsController < ApplicationController
  before_action :load_product, only: %i(create update)
  before_action :load_item, only: :destroy
  def index; end

  def create
    @cart = current_cart
    @line_item = @cart.add_product @product.id
    if @line_item.save
      respond_to do |format|
        format.html{redirect_to root_url, notice: t("static_pages_controller.succsess")}
        format.json{head :no_content}
      end
    else
      redirect_to root_url
    end
  end

  def destroy
    if @delete_item.destroy
      flash[:success] = t "static_pages_controller.item_path"
    else
      flash[:warning] = t "static_pages_controller.error_item"
    end
    redirect_to cart_path(session[:cart_id])
  end

  def update
    @cart = current_cart
    @line_item = @cart.decrease_product @product.id
    if @line_item.save
      respond_to do |format|
        format.html{redirect_to @line_item.cart}
        format.json{head :no_content}
      end
    else
      redirect_to @line_item.cart
    end
  end

  private

  def load_product
    @product = Product.find_by id: params[:product_id]
    return if @product
    flash[:warning] = t "static_pages_controller.error_product"
    redirect_to root_url
  end

  def load_item
    @delete_item = LineItem.find_by id: params[:id]
    return if @delete_item
    flash[:warning] = t "static_pages_controller.error_item"
    redirect_to cart_path(session[:cart_id])
  end
end
