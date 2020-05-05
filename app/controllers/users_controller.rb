class UsersController < ApplicationController
  before_action :load_user, only: %i(edit update show index)

  def show; end

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
      flash[:success] = t "admin.deleted"
    else
      flash[:warning] = t "admin.notdelete"
    end
    redirect_to user_path
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:warning] = t "users_controller.errorss"
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone, :address, :password,
      :password_confirmation)
  end
end
