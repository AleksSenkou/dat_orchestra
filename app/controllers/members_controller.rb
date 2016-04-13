class MembersController < ApplicationController
  def index
    @members = Member.includes(:picture, :instruments, :translations).all
  end
end
