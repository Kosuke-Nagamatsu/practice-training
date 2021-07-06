class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :access_limit_after_login, only: [:new]
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end
  def show
    @user = User.find(params[:id])
    redirect_to tasks_path unless @user.id == current_user.id
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
