class ContactsController < ApplicationController
  def index
    @contacts = Contact.first
    @message = Message.new

    gon.push(
      lat: @contacts.lat,
      lng: @contacts.lng
    )
  end
end
