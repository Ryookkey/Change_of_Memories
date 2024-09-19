class Public::UsersController < ApplicationController
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
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
  end

  private

  def post_params
    params.require(:post).permit(:first_memo)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :introduction)  # 更新するフィールドを指定
  end

end
