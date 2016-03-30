class SessionsController < ApplicationController
  def new
    respond_to do |format|
      format.html { render :new}
      format.js   { redirect_to root_path }
    end
  end

  def create
    user = User.find_by_email params[:sessions][:email]
    if user && user.authenticate(params[:sessions][:password])
      sign_in user
      redirect_to root_path, notice: "Signed in!"
    else
      flash[:alert] = "Wrong credentials!"
      render :new
    end
  end

  def confirm_user
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out!"
  end
end
