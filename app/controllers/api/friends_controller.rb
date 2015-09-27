class Api::FriendsController < ApplicationController

  def create
    @friendship = Friend.new(friend_params)
    if @friendship.save
      render json: @friendship
    else
      render json: @friendship.errors.full_messages, status: 422
    end
  end

  def update
    @friendship = Friend.find(params[:id])
    if @friendship.update(friend_params)
      friendship_id = friend_params[:id]
      user1_id = Friend.find(friendship_id)[:user_id]
      user2_id = Friend.find(friendship_id)[:friend_id]
      Rails.cache.write("#{user1_id}.friend_ids", User.find_by_id(user1_id).friend_ids)
      Rails.cache.write("#{user2_id}.friend_ids", User.find_by_id(user2_id).friend_ids)
      render json: @friendship
    else
      render json: @friendship.errors.full_messages, status: 422
    end
  end

  def destroy
    @friendship = Friend.find(params[:id])
    friendship_id = @friendship[:id]
    user1_id = Friend.find(friendship_id)[:user_id]
    user2_id = Friend.find(friendship_id)[:friend_id]
    @friendship.destroy
    Rails.cache.write("#{user1_id}.friend_ids", User.find_by_id(user1_id).friend_ids)
    Rails.cache.write("#{user2_id}.friend_ids", User.find_by_id(user2_id).friend_ids)
    render json: @friendship, status: 200
  end

  def friend_params
    params.require(:friend).permit(:id, :user_id, :friend_id, :pending)
  end
end
