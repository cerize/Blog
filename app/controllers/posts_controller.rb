class PostsController < ApplicationController

  before_action :authenticate_user, except: [:index, :show, :search]

  before_action :authorize_user, only: [:new, :create, :edit, :update, :destroy]

    def new
      @post = Post.new
    end

    def create
      @post = Post.new post_params
      @post.user = current_user
      if @post.save
        flash[:notice] = "Post Created Successfully"
        redirect_to post_path(@post)
      else
        flash.notice = "Post was not created"
        render :new
      end
    end

    def index
      @posts = Post.order("created_at DESC").page(params[:page]).per(5)
    end

    def show
      @comment = Comment.new
      @post = find_post
      @comments = @post.comments.order("created_at DESC")
      @favourite = @post.favourite_by(current_user)
    end

    def editmments
      find_post
      render :edit
    end

    def update
      @post = find_post
      if @post.update post_params
        redirect_to post_path(@post)
      else
        flash[:notice] = "Changes were not saved"
        render :edit
      end
    end

    def destroy
      if find_post.destroy
        redirect_to posts_path
      else
        render nothing:true
      end
    end

    def search
      @posts = Post.search(params[:q]).page(params[:page]).per(5)
      render :index
    end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id, :image)
  end

  def find_post
    @post = Post.find params[:id]
  end

  def authorize_user
    unless can? :manage, @posts
      redirect_to root_path, alert: "access denied!"
    end
  end



end
