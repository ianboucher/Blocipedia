class UsersController < ApplicationController

  def show
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # binding.pry
    if @user.update_attribute(:role, params[:role])
      flash[:notice] = "Your account was successfully updated"
      redirect_to user_path
    else
      flash[:alert] = "There was an error updating your account. Please try again."
      redirect_to user_path
    end
  end

  # private
  #
  # def user_params
  #   #binding.pry
  #   params.require(:user).permit(:role, :username, :email, :password)
  # end

end
