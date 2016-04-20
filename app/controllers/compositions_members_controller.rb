class CompositionsMembersController < ApplicationController
  before_action :load_member, :load_composition

  def create
    @member.compositions << @composition

    render nothing: true
  end

  def destroy
    @member.compositions.delete @composition

    render nothing: true
  end

  private

  def load_member
    @member = Member.find params[:member_id]
  end

  def load_composition
    @composition = Composition.find params[:composition_id]
  end
end
