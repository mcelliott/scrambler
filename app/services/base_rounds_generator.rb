class BaseRoundsGenerator
  attr_reader :event
  def initialize(event, params)
    @event = event
    @params = params
  end

  protected

  def create_team(category, round)
    TeamCreator.new(event, category, round).perform
  end

  def create_round(num_round)
    RoundCreator.new(event, num_round).perform
  end

  def mixed_rounds
    @params[:mixed_rounds] ? @params[:mixed_rounds].keys.map(&:to_i) : []
  end

  def create_team_participants(team_participants, team)
    team_participants.each do |participant|
      byebug unless participant
      TeamParticipantCreator.new(event, participant.id, team).perform
    end
  end

  def participant_combinations(participants)
    participants.map(&:id).combination(event.team_size).to_a.map do |tp|
      Participant.find(tp)
    end
  end
end
