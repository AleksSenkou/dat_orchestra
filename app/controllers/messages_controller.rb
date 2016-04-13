class MessagesController < ApplicationController
  skip_before_action :load_base_page

  def create
    @message = Message.new message_params

    sleep(0.04)

    if @message.save
      @message = Message.new
    else
      render 'new'
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :message)
  end
end
