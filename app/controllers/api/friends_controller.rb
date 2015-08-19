class Api::FriendsController < ApplicationController

  def create
    @friendship = current_user.friends.new(friend_params)
    if @friendship.save
      render json: @friendship
    else
      render json: @friendship.errors.full_messages, status: 422
    end
  end

  def index
    @friendships = User.find(params[:user_id]).friends
    # render json: @friendships
  end

  def update
    @friendship = Friend.find(params[:id])
    if @friendship.update(friend_params)
      render json: @friendship
    else
      render json: @friendship.errors.full_messages, status: 422
    end
  end



  def destroy
    @friendship = Friend.find(params[:id])
    @friendship.destroy
    render json: @friendship, status: 200
  end

  def friend_params
    params.require(:friend).permit(:friend_id, :pending)
  end
end
