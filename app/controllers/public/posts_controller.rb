class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    # @user = User.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.group = Group.create!

    if @post.save
      redirect_to public_user_path(current_user)  # @post を渡して詳細ページに遷移
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to public_post_path(post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to public_user_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:first_memo, :second_memo, :third_memo)
  end

end
