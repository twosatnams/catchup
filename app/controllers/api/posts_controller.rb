class Api::PostsController < ApplicationController

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post
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
    render json: @post
  end

  def post_params
    params.require(:post).permit(:body, :author_id)
  end
end
