class FavouritesController < ApplicationController
  before_action :authenticate_user

  def create
    @post = Post.find params[:post_id]
    if user_signed_in?
    @favourite = Favourite.new(post:@post, user: current_user)
    respond_to do |format|
      if @favourite.save
        format.html {redirect_to post, notice: "This post is a favourite now!"}
        format.js {render :favourite}
      else
        format.html {redirect_to post, alert: "ERROR: could not favourite."}
        format.js {render :favourite}
      end
    end
  else
    redirect_to new_session_path, alert: "Please sign in to favourite this post"
  end
  end


  def destroy
    @favourite = current_user.favourites.find params[:id]
    @post = Post.find params[:post_id]
    @favourite.destroy
    respond_to do |format|
      format.html {redirect_to post, alert: "Post removed from favs"}
      format.js {render :favourite}
    end
  end








end
