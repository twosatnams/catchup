class Api::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :dob, :city,
                        :school, :workplace, :profile_pic, :cover_pic)
  end
end
