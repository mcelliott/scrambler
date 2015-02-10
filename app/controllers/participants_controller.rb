class ParticipantsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /participants/new
  def new
    @participant = Participant.new
    @participant.event = current_event
  end

  # POST /participants
  # POST /participants.json
  def create
    @participant = current_user.participants.build(participant_params)
    @participant.number = current_event.participants.count + 1
    @participant.create_payment(event: current_event, amount: current_event.participant_cost)
    flash[:notice] = 'Participant was successfully created.' if @participant.save
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    @participant.destroy
    respond_to do |format|
      format.html { redirect_to event_path(@participant.event), notice: 'Participant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show
    @participant = current_user.participants.find(params[:id])
  end

  private

  def current_event
    @event ||= Event.find params[:event_id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def participant_params
    params.require(:participant).permit(:flyer_id, :category_id, :event_id)
  end
end
