class Admin::UsersController < ApplicationController
  def index
    @users = User.all # すべてのユーザーを取得
  end

  def show
    @user = User.find(params[:id]) # 特定のユーザー情報を取得
    @users = User.all
    @posts = @user.posts
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to public_user_path(current_user)
  end
end