class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :correct_user, only: [:edit, :update, :favorites]

  def show
    @user = User.find(params[:id])

    sort_order = params[:sort] == 'old' ? 'created_at ASC' : 'created_at DESC'

    @posts = @user.posts.order(sort_order).page(params[:page]).per(2)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user && @user.update(user_params)
      redirect_to public_user_path(@user), notice: "プロフィールを更新しました。"
    else
      flash[:alert] = "ご利用できない画像です。 ご利用いただける画像ファイルはpng、jpg、jpeg形式で4MB以下になります。 今一度ご確認をお願いします。"
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
    @favorite_posts = Post.joins(:favorites).where(favorites: { user_id: current_user.id })
                          .page(params[:page]).per(3)
  end

  private

  def correct_user
    @user = User.find(params[:id] || params[:user_id])
    unless @user == current_user
      flash[:alert] = "他のユーザーのプロフィールは編集できません。"
      redirect_to public_user_path(current_user)
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile_image, :introduction)
  end
end
