class MemberInstrumentsController < ApplicationController
  before_action :load_member, :load_instrument

  def create
    @member.instruments << @instrument

    render nothing: true
  end

  def destroy
    @member.instruments.delete @instrument

    render nothing: true
  end

  private

  def load_member
    @member = Member.find params[:member_id]
  end

  def load_instrument
    @instrument = Instrument.find params[:instrument_id]
  end
end
