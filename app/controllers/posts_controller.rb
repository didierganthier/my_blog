class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def new
    @post = Post.new
    @current_user = current_user
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comments = Comment.where(post_id: params[:id]).order(created_at: :desc).limit(5)
  end

  # def create
  #   @post = Post.new(post_params)
  #   @post.author_id = current_user.id
  #   @post = current_user.posts.build(post_params)
  #   @post.likes_counter = 0
  #   @post.comments_counter = 0
  #   if @post.save
  #       flash[:notice] = "Post created successfully"
  #       redirect_to user_posts_path(current_user)
  #   else
  #       flash[:alert] = "Post creation failed"
  #       render :new
  #   end
  # end

  def create    
    @post = Post.new(post_params)    
    @post.author = current_user    
    @post.likes_counter = 0    
    @post.comments_counter = 0    
    if @post.save      
      redirect_to user_posts_path(current_user)    
    else      
      render :new, status: :unprocessable_entity    
    end  
  end

  private
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
