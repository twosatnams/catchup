class Api::PhotosController < ApplicationController

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      render json: @photo
    else
      render json: @photo.errors.full_messages, status: 422
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    render json: @photo, status: 200
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:url, :post_id)
  end
end
