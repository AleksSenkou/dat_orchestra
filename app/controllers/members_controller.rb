class MembersController < ApplicationController
  def index
    @members = Member.includes(:picture, :instruments).all
  end
end
