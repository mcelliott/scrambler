class BaseRoundsGenerator
  attr_reader :event

  def initialize(event, mixed_rounds)
    @event = event
    @mixed_rounds = mixed_rounds
  end

  protected

  def create_team(category, round)
    TeamCreator.new(event, category, round).perform
  end

  def create_round(num_round)
    RoundCreator.new(event, num_round).perform
  end

  def mixed_rounds
    @mixed_rounds ? @mixed_rounds.map(&:to_i) : []
  end

  def create_team_participants(team_participants, team)
    team_participants = team_participants.compact
    team_participants.each do |participant|
      TeamParticipantCreator.new(form(participant, team)).save
    end
  end

  def participant_combinations(participants)
    participants.map(&:id).combination(event.team_size).to_a.map do |tp|
      Participant.find(tp)
    end
  end

  def form(participant, team)
    params = {
      team_id: team.id,
      event_id: event.id,
      participant_id: participant.id,
      placeholder: false
    }
    team_participant = TeamParticipant.new(params)
    TeamParticipantForm.new(team_participant)
  end

  def percent_complete
    (1.0 * event.reload.rounds.size / event.num_rounds * 100.0).round
  end
end
