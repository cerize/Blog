class CommentsController < ApplicationController
  before_action :find_comment, only: [:edit, :update, :destroy]

  before_action :find_post, only: [:create, :edit, :update, :destroy]

  before_action :authenticate_user

  before_action :authorize_user, only: [:edit, :update, :destroy]



  def create
    @comment = Comment.new comment_params
    @comment.post = @post
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: "Comment created!" }
        format.js { render :create_success }
      else
        #flash.notice = "Comment was not created"
        format.html { render post_path(@post) }
        format.js   { render :create_fail }
      end

    end
  end

  def edit
    respond_to do |format|
      format.html { render :edit }
      format.js { render }
    end
  end

  def update
    respond_to do |format|
      if @comment.update comment_params
        format.html { redirect_to post_path(@post) }
        format.js   { render :update_success }
      else
        #flash[:notice] = "Changes were not saved"
        format.html { render :edit }
        format.js   { render :update_fail }
      end
    end
  end

  def destroy
    find_comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.js   { render }

    end
  end

private

def comment_params
  params.require(:comment).permit(:body)
end

def find_comment
  @comment = Comment.find params[:id]
end

def find_post
  @post = Post.find params[:post_id]
end

def authorize_user
  unless can? :manage, @comment
    redirect_to root_path, alert: "access denied!"
  end
end





end
