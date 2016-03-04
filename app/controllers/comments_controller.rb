class CommentsController < ApplicationController
  before_action :find_comment, only: [:edit, :update, :destroy]

  before_action :authenticate_user

  before_action :authorize_user, only: [:edit, :update, :destroy]



  def create
    @post = Post.find params[:post_id]
    @comment = Comment.new comment_params
    @comment.post = @post
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post), notice: "Comment created!"
    else
      flash.notice = "Comment was not created"
      render post_path(@post)
    end
  end

  def edit
    @post = Post.find params[:post_id]
    render :edit
  end

  def update
    @post = Post.find params[:post_id]
    @comment = find_comment
    if @comment.update comment_params
      redirect_to post_path(@post)
    else
      flash[:notice] = "Changes were not saved"
      render :edit
    end
  end

  def destroy
    # render json: params
    @post = params[:post_id]
    if find_comment.destroy
      redirect_to post_path(@post)
    else
      render nothing:true
    end
  end

private

def comment_params
  params.require(:comment).permit(:body)
end

def find_comment
  @comment = Comment.find params[:id]
end

def authorize_user
  unless can? :manage, @comment
    redirect_to root_path, alert: "access denied!"
  end
end





end
