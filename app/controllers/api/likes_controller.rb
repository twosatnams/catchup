class Api::LikesController < ApplicationController

  def create
    @like = current_user.likes.new(like_params)
    if @like.save
      render json: @like
    else
      render json: @like.errors.full_messages, status: 422
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    render json: @like, status: 200
  end

  def like_params
    params.require(:like).permit(:post_id)
  end
end
