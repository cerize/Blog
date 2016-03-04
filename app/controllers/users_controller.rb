class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.find params[:id]
    render :show
  end

  def create
    user_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    @user = User.new(user_params)
    if @user.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @user = User.find params[:id]
    render :edit
  end

  def update
    @user = User.find params[:id]
    if @user.update user_params
      redirect_to user_path(@user)
    else
      flash[:notice] = "Changes were not saved"
      render :edit
    end
  end

  def edit_password
    @user = User.find params[:id]
  end

  def update_password
    @user = User.find params[:id]
    params.require(:user).permit(:password, :new_password, :new_password_confirmation)
    if @user && @user.authenticate(params[:user][:password])
      if params[:user][:new_password] == params[:user][:new_password_confirmation]
        if params[:user][:new_password] != params[:user][:password]
          @user.password = params[:user][:new_password]
          @user.save
          redirect_to root_path, notice: "Password changed!!"
        else
          flash[:alert] = "New password must be different from current password!"
          render :edit_password
        end
      else
        flash[:alert] = "Password could not be changed, confirmation failed!"
        render :edit_password
      end
    else
      flash[:alert] = "Password could not be changed, wrong credentials!"
      render :edit_password
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end





end
