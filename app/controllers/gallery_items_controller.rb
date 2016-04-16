class GalleryItemsController < ApplicationController
  def index
    @gallery_items =
      GalleryItem.includes(:translations).paginate(page: params[:page], per_page: 50)
  end
end
