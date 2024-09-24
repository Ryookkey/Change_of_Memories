class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:show, :edit, :update, :favorites]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.group_by(&:group_id)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to public_user_path(@user)
    else
      render :edit
    end
  end

  def unsubscribe
    @user = current_user
    @user.destroy
    reset_session
    redirect_to new_user_registration_path, notice: "退会が完了しました"
  end

  def favorites
    @user = current_user
    @favorite_posts = @user.favorites.includes(:post).map(&:post)
  end

  private

  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:alert] = "アクセス権限がありません。"
      redirect_to public_user_path(current_user)
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile_image, :introduction)
  end
end
