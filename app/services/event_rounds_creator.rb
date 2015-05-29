class EventRoundsCreator
  include Sidekiq::Worker
  sidekiq_options queue: 'rounds'

  def perform(event_id, mixed_rounds)
    event = event(event_id)
    event.rounds.destroy_all if event.rounds.present?

    # generate the rounds
    rg = RoundGenerator.new(event, @params[:mixed_rounds].try(:keys) || [])
    rg.perform

    # apply to event
    progress_updater = ProgressUpdater.new(event)
    rg.rounds.each do |round_number, teams|
      round = RoundCreator.new(event, round_number).perform
      teams.each do |team_number, value|
        value.each do |category_name, participants|
          category = Category.find_by(name: category_name)
          team = round.teams.create(name: "Team #{team_number}",
                                    category: category,
                                    event: event)

          participants.each do |participant|
            TeamParticipantCreator.new(form(participant, team)).save
          end
        end
        progress_updater.update(percent_complete)
      end
    end
    ProgressUpdater.new(event).update(100)
    event.reload
  end

  def form(participant, team)
    team_participant = TeamParticipant.new(
      team_id: team.id,
      event_id: event.id,
      participant_id: participant.id,
      placeholder: false)
    TeamParticipantForm.new(team_participant)
  end

  def event(id)
    @event ||= Event.includes(:rounds, :participants).find(id)
  end

  def percent_complete
    (1.0 * event.reload.rounds.size / event.num_rounds * 100.0).round
  end
end
