class MessagesController < ApplicationController
  def create
    @message = Message.new message_params

    sleep(0.15)

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
