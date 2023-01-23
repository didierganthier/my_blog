# In the PostsController, create an index action that retrieves all the posts for a specified user and renders the index view.
# In the PostsController, create a show action that retrieves a specified post and its comments and likes and renders the show view.
class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @likes = @post.likes
  end
end