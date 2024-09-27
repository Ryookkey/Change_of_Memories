module Public
  class CommentsController < ApplicationController
    def create
      post = Post.find(params[:post_id])
      comment = post.comments.new(post_comment_params)
      comment.user = current_user
      if comment.save
        redirect_to public_post_path(post), notice: 'コメントが保存されました'
      else
        redirect_to public_post_path(post), alert: 'コメントの保存に失敗しました'
      end
    end

    def destroy
      post = Post.find(params[:post_id])
      comment = post.comments.find(params[:id])
      if comment.user == current_user
        comment.destroy
        redirect_to public_post_path(post), alert: 'コメントが削除されました。'
      else
        redirect_to public_post_path(@post), alert: 'コメントの削除権限がありません。'
      end
    end

    private

    def post_comment_params
      params.require(:comment).permit(:comment)
    end
  end
end