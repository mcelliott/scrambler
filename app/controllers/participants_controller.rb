class ParticipantsController < ApplicationController
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
    respond_to do |format|
      if @participant.save
        format.html { redirect_to @participant.event, notice: 'Participant was successfully created.' }
        format.js
      else
        format.js
        format.html { render :new }
      end
    end
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

  private

  def current_event
    @event ||= Event.find params[:event_id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def participant_params
    params.require(:participant).permit(:flyer_id, :category_id, :event_id)
  end
end
