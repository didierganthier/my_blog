class CommentsController < ApplicationController
    before_action :set_post, only: [:create]

    def create    
        @comment = Comment.new(comment_params)    
        @comment.post = @post    
        @comment.author = current_user    
        if @comment.save
            flash[:notice] = "Comment was successfully created."      
            redirect_to user_post_path(current_user, @post)    
        else
            flash[:alert] = "Comment was not created."      
            render :new, status: :unprocessable_entity    
        end  
    end

    def new
        @comment = Comment.new
        @current_user = current_user
    end  
  
    private
    
    def set_post
        @post = Post.find(params[:post_id])
    end
  
    def comment_params
      params.require(:comment).permit(:text)
    end
  end