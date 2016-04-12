class PagesController < ApplicationController
  def home
    @compositions = Composition.includes(:picture, members: :picture).first(9)
  end

  def contacts
    @contacts = Contact.first
    @message = Message.new
  end
end
