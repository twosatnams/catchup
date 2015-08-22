class Api::PostsController < ApplicationController
  def create
    @post = current_user.posts.new(post_params)
    @post.photos.build(photo_params) if params[:photos] != nil
    if @post.save
      render :show
    else
      render json: @post.errors.full_messages, status: 422
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors.full_messages, status: 422
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    render json: @post, status: 200
  end

  def show
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body)
  end

  def photo_params
    params.permit(:photos => [:url]).require(:photos)
  end
end
