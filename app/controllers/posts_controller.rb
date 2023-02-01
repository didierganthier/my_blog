class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes([:comments])
  end

  def new
    @post = Post.new
    @current_user = current_user
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.includes([:author]).find(params[:id])
    @comments = Comment.includes([:author]).where(post_id: params[:id]).order(created_at: :desc).limit(5)
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    @post.likes_counter = 0
    @post.comments_counter = 0
    if @post.save
      flash[:notice] = 'Post created successfully'
      redirect_to user_posts_path(current_user)
    else
      flash[:alert] = 'Post creation failed'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @user = @post.author
    # check if there are any comments or likes associated with the post
    if @post.comments_counter > 0 || @post.likes_counter > 0
      if @post.comments_counter > 0
        @post.comments.each do |comment|
          comment.destroy
        end
      end
      if @post.likes_counter > 0
        @post.likes.each do |like|
          like.destroy
        end
      end
    end
    @post.destroy
    @user.posts_counter -= 1
    flash[:notice] = 'Post deleted successfully'
    # delete all comments and likes associated with the post

    redirect_to user_posts_path(@user) if @user.save
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
