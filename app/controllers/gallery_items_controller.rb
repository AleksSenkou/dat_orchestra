class GalleryItemsController < ApplicationController
  def index
    @gallery_items = GalleryItem.all
  end
end
