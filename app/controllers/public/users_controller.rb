class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :correct_user, only: [:show, :edit, :update, :favorites]

  def show
    @user = User.find(params[:id])
    # @postsにはページネーションされた結果をそのまま渡す
    @posts = @user.posts.page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      flash[:alert] = "他のユーザーのプロフィールは編集できません。"
      redirect_to public_user_path(@user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user && @user.update(user_params)
      redirect_to public_user_path(@user), notice: "プロフィールを更新しました。"
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
    @favorite_posts = Post.joins(:favorites).where(favorites: { user_id: current_user.id })
                          .page(params[:page]).per(3)
  end

  private

  def correct_user
    user_id = params[:id] || params[:user_id]
    @user = User.find(user_id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile_image, :introduction)
  end
end
