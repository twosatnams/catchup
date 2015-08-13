class Api::PostsController < ApplicationController

  def create
    @post = Post.new(post_params)
  end

  def update

  end

  def destroy
    @post = Post.find(params[:id])
  end
end
