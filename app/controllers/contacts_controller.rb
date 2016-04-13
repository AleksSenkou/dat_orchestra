class ContactsController < ApplicationController
  def index
    @contacts = Contact.first
    @message = Message.new

    gon.push(
      lat: @contacts.lat || 53.9145418,
      lng: @contacts.lng || 27.5845092
    )
  end
end
