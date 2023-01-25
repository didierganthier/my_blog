class LikesController < ApplicationController
    def create
      @like = Like.new
      @post = Post.find(params[:post_id])
      @user = User.find(params[:user_id])
      @like.post = @post
      @like.author = current_user
      if @like.save
        flash[:notice] = "Like created successfully"
        redirect_to user_post_path(@user, @post)
      else
        flash[:alert] = "Like creation failed"
        render :new, status: :unprocessable_entity
      end
    end
  end