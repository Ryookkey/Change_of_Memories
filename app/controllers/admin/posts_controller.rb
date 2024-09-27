class Admin::PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all.page(params[:page]).per(2)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "投稿が削除されました。"
    redirect_to admin_posts_path
  end

end
