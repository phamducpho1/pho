class Admin::CategoriesController < ApplicationController
  before_action :admin_user, only: :destroy
  before_action :load_category, only: %i(edit destroy update)
  load_and_authorize_resource

  def index
    @categories = Category.sort_by_category
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:info] = t "admin.create"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "admin.updatesuc"
    else
      flash[:warning] = t "admin.updatefail"
    end
    redirect_to admin_categories_path
  end

  def destroy
    if @category.destroy
      flash[:success] = t "admin.deleted"
    else
      flash[:warning] = t "admin.notdelete"
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:warning] = t "users_controller.errorss"
    redirect_to admin_categories_path
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
