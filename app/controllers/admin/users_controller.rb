class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @users = User.all
    @posts = @user.posts
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "ユーザーを退会させました。"
    redirect_to admin_users_path
  end
end