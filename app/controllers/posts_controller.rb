class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def new
    @post = Post.new
    @post.author_id = current_user.id
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comments = Comment.where(post_id: params[:id]).order(created_at: :desc).limit(5)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
        flash[:notice] = "Post created successfully"
        redirect_to user_post_path(current_user, @post)
    else
        flash[:alert] = "Post creation failed"
        render :new
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
