class LikesController < ApplicationController
  def create
    @like = Like.new
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @like.post = @post
    @like.author = current_user
    if @like.save
      flash[:notice] = 'Like was successfully created.'
      redirect_to user_post_path(@user, @post)
    else
      flash[:alert] = 'Like was not created.'
      render :new, status: :unprocessable_entity
    end
  end
end
