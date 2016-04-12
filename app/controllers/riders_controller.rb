class RidersController < ApplicationController
  def index
    @riders = Rider.all
  end

  def download
    rider = Rider.find params[:id]

    send_file rider.document.path,
      filename: rider.document_file_name,
      type: rider.document_content_type
  end
end
