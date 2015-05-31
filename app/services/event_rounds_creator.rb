class EventRoundsCreator
  def initialize(params)
    ActiveRecord::Base.logger.level = 1
    @params = params
  end

  def reset
    event.rounds.destroy_all if event.rounds.present?
  end

  def perform
    # generate the rounds
    rg = RoundGenerator.new(event, @params[:mixed_rounds].try(:keys) || [])
    rg.perform

    # apply to event
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
      end
    end
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

  def event
    @event ||= Event.includes(:rounds, :participants).find(@params[:event_id])
  end
end
