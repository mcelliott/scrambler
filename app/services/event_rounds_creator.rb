class EventRoundsCreator
  include Sidekiq::Worker
  sidekiq_options queue: 'rounds', retry: false

  def perform(event_id, mixed_rounds)
    event = event(event_id)
    event.rounds.destroy_all if event.rounds.present?

    # generate the rounds
    rg = RoundGenerator.new(event, mixed_rounds)
    rg.generate

    # check for dups
    rg.check_rounds

    # apply to event
    progress_updater(event) do |progress|
      rg.rounds.each do |round_number, teams|
        round = RoundCreator.new(event, round_number).perform
        create_teams(round, teams)
        progress.update(percent_complete)
      end
      event.reload
    end
  end

  def create_teams(round, teams)
    teams.each do |team_number, value|
      value.each do |category_name, participants|
        category = find_category_by_name(category_name)
        team_creator = TeamCreator.new(team_number,
                                       @event,
                                       round,
                                       category)
        team = team_creator.perform
        create_participants(team, participants)
      end
    end
  end

  def create_participants(team, participants)
    participants.each do |participant|
      TeamParticipantCreator.new(form(participant, team)).save
    end
  end

  def form(participant, team)
    params = {
      team_id: team.id,
      event_id: @event.id,
      participant_id: participant.id,
      placeholder: false
    }
    TeamParticipantForm.new(TeamParticipant.new(params))
  end

  def event(id)
    @event ||= Event.includes(:rounds, :participants).find(id)
  end

  def percent_complete
    (1.0 * @event.reload.rounds.size / @event.num_rounds * 100.0).round
  end

  private

  def find_category_by_name(name)
    Category.find_by(name: name)
  end

  def progress_updater(event)
    progress_updater = ProgressUpdater.new(event)
    yield progress_updater
    progress_updater.update(100)
  end
end
