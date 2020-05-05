class Admin::ProductsController < ApplicationController
  before_action :admin_user, only: :destroy
  before_action :load_product, only: %i(destroy edit update)
  before_action :check_if_has_line_item, only: :destroy
  load_and_authorize_resource

  def show; end

  def index
    @product = Product.find_category(params[:q])
    @products = Product.sort_by_products
    @categories = Category.sort_by_category
  end

  def new
    @product = Product.new
    @cate = Category.sort_by_category
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = t "admin.create"
      redirect_to admin_products_path
    else
      render :new
    end
  end

  def edit
    @cate = Category.sort_by_category
  end

  def update
    if @product.update_attributes(product_params)
      flash[:success] = t "admin.updatesuc"
    else
      flash[:warning] = t "admin.updatefail"
    end
    redirect_to admin_products_path
  end

  def destroy
    if @product.destroy
      flash[:success] = t "admin.deleted"
    else
      flash[:warning] = t "admin.notdelete"
    end
    redirect_to admin_products_path
  end

  private

  def check_if_has_line_item
    return if @product.order_details.empty?
    flash[:danger] = t "admin.notdelete"
    redirect_to admin_products_path
  end

  def product_params
    params.require(:product).permit(:name, :price, :quanlity, :image, :information, :category_id)
  end

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:warning] = t "users_controller.errorss"
    redirect_to admin_products_path
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
