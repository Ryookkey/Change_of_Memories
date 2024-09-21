class Public::FavoritesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id, group_id: post.group_id)

    if favorite.save
      flash[:notice] = "いいねを追加しました"
    else
      flash[:alert] = favorite.errors.full_messages.to_sentence
    end
    redirect_to public_post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)

    if favorite.present?
      favorite.destroy
      flash[:notice] = "いいねを削除しました"
    else
      flash[:alert] = "いいねの削除に失敗しました"
    end
    redirect_to public_post_path(post)
  end

end