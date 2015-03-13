class EventRoundsCreator
  def initialize(params)
    ActiveRecord::Base.logger.level = 1
    @params = params
    @team_list = []
  end

  def reset
    event.rounds.destroy_all if event.rounds.present?
  end

  def perform
    BasicRoundCreator.new(event, @params, @team_list).perform
    MixedRoundCreator.new(event, @params, @team_list).perform
    event.reload
  end

  def event
    @event ||= Event.includes(:rounds, :participants).find(@params[:event_id])
  end
end
