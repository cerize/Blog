class FavouritesController < ApplicationController
  before_action :authenticate_user

  def create
    post = Post.find params[:post_id]
    favourite = Favourite.new(post: post, user: current_user)
    if favourite.save
      redirect_to post, notice: "This post is a favourite now!"
    else
      redirect_to post, alert: "ERROR: could not favourite."
    end
  end


  def destroy
    favourite = current_user.favourites.find params[:id]
    post = Post.find params[:post_id]
    favourite.destroy
    redirect_to post, alert: "Post removed from favs"
  end








end
