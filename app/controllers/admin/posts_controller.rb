class Admin::PostsController < ApplicationController
  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "投稿が削除されました。"
    redirect_to admin_user_path(post.user) # 削除後にユーザー詳細ページにリダイレクト
  end
end
