class Admin::UsersController < ApplicationController
  before_action :admin_user, only: :destroy
  before_action :load_user, only: %i(destroy update edit)
  load_and_authorize_resource

  def show; end

  def index
    @users = User.sort_by_name.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t "users_controller.signup"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t "admin.updatesuc"
    else
      flash[:warning] = t "admin.updatefail"
    end
    redirect_to admin_users_path
  end

  def destroy
    if @user.destroy
      flash[:success] = t "admin.deleted"
    else
      flash[:warning] = t "admin.notdelete"
    end
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :address, :password,
      :password_confirmation, :admin)
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:warning] = t "users_controller.errorss"
    redirect_to users_path
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
