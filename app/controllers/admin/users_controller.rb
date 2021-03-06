class Admin::UsersController < ApplicationController
  skip_before_action :login_required
  before_action :if_not_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.includes(:tasks)
    @users = @users.page(params[:page]).per(10)
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to admin_users_path, notice: "新規作成しました！"
    else
      render :new
    end
  end
  def show
  end
  def edit
  end
  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "更新しました！"
    else
      render :edit
    end
  end
  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "削除しました！"
    end
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
  def set_user
    @user = User.find(params[:id])
  end
end
