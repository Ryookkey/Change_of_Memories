class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id, group_id: post.group_id)

    if favorite.save
      flash[:notice] = "いいねを追加しました"
    else
      flash[:alert] = favorite.errors.full_messages.to_sentence
    end
    redirect_to request.referer
  end

  def index
    sort_order = params[:sort] == 'likes_desc' ? 'desc' : 'asc'
    @favorite_posts = Post.joins(:favorites)
                          .where(favorites: { user_id: current_user.id })
                          .group('posts.id')
                          .order("COUNT(favorites.id) #{sort_order}")
                          .page(params[:page])
                          .per(3)
  end


  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)

    if favorite.present?
      favorite.destroy
      flash[:alert] = "いいねを削除しました"
    else
      flash[:alert] = "いいねの削除に失敗しました"
    end
    redirect_to request.referer
  end

end