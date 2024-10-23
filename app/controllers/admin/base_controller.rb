class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!

  private

  def authenticate_admin!
    if current_user
      redirect_to user_path(current_user), alert: '管理者専用ページのためアクセスできません'
    elsif !current_admin
      # 管理者がログインしていない場合、ログインページにリダイレクト
      redirect_to new_admin_session_path, alert: '管理者としてログインしてください'
    end
  end
end
