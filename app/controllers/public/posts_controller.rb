class Public::PostsController < ApplicationController
  before_action :authenticate_user!  
  before_action :correct_user, only: [:edit, :update, :destroy]  
  
  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
    @post = Comment.new
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.group = Group.create!

    if @post.save
      if params[:next_step] && params[:next_step] == 'true'
        redirect_to second_memo_public_post_path(@post)
      else
        redirect_to public_user_path(current_user)
      end
    else
      render :new
    end
  end

  def second_memo
    @post = Post.find(params[:id])
    if request.patch?
      if @post.update(post_params)
        if params[:next_step] && params[:next_step] == 'true'
          redirect_to third_memo_public_post_path(@post) 
        else
          redirect_to public_user_path(current_user) 
        end
      else
        render :second_memo
      end
    end
  end
  
  def third_memo
    @post = Post.find(params[:id])
    if request.patch?
      if @post.update(post_params)
        redirect_to public_user_path(current_user) 
      else
        render :third_memo
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      redirect_to public_post_path(post.id)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to public_user_path(current_user)
  end

  private

  def correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      flash[:alert] = "権限がありません。"
      redirect_to public_post_path
    end
  end
  
  def post_params
    params.require(:post).permit(:first_memo, :second_memo, :third_memo)
  end
end
