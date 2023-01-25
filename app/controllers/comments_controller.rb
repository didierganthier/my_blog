class CommentsController < ApplicationController
    def create
      @comment = Comment.new(comment_params)
      @comment.post = @post
      @comment.author = current_user
      if @comment.save
        flash[:notice] = "Comment created successfully"
        redirect_to user_post_path(@user, @post)
      else
        flash[:alert] = "Comment creation failed"
        render :new, status: :unprocessable_entity
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:text)
    end
  end