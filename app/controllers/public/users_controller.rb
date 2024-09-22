class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
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
    # ユーザーを削除
    @user.destroy
    # ログアウト処理
    reset_session
    # 会員登録ページにリダイレクト
    redirect_to new_user_registration_path, notice: "退会が完了しました"
  end

  private

  def post_params
    params.require(:post).permit(:first_memo)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :introduction)
  end
end
