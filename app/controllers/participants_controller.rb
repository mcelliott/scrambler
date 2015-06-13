class ParticipantsController < ApplicationController
  include UndoDelete
  before_action :authenticate_user!, except: :show
  load_and_authorize_resource except: [:create, :show]

  decorates_assigned :event
  decorates_assigned :participant
  decorates_assigned :team_participant

  def new
    current_event
    @q = Flyer.order(name: :asc).search(params[:q])
    @flyers = @q.result.page(params[:page]).per(10)
  end

  def create
    @participant = Participant.new(event: current_event)
    @form = ParticipantForm.new(@participant)
    @form.update!(params[:participant])

    if ParticipantCreator.new(@form).save
      @success = true
      flash[:notice] = 'Participant was successfully created.'
    else
      flash[:alert] = 'Failed to add Participant to event.'
    end
  end

  def destroy
    current_event
    destroy_team_participant
    if @participant.destroy
      flash[:notice] = "Participant was successfully deleted. #{undo_link(@participant)}"
    else
      flash[:alert] = 'Failed to delete participant.'
    end
  end

  def show
    @participant = Participant.find(params[:id])
  end

  private

  def destroy_team_participant
    @team_participant = TeamParticipant.find_by(participant_id: @participant.id)
    @team_participant.destroy! if @team_participant.present?
  end

  def current_event
    @event ||= Event.find(params[:event_id])
  end
end
