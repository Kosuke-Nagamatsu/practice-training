class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required
  private
  def login_required
    redirect_to new_session_path unless current_user
  end
  def access_limit_after_login
    redirect_to user_path(current_user.id) if current_user
  end
  def if_not_admin
    if current_user && current_user.admin == "なし"
      flash[:danger] = '管理者ではないのでアクセスできません'
      redirect_to tasks_path
    end
  end
end
