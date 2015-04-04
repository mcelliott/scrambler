class EventRoundsCreator
  def initialize(params)
    ActiveRecord::Base.logger.level = 1
    @params = params
  end

  def reset
    event.rounds.destroy_all if event.rounds.present?
  end

  def perform
    RoundsGenerator.new(event, @params).perform
    MixedRoundsGenerator.new(event, @params).perform
    event.reload
  end

  def event
    @event ||= Event.includes(:rounds, :participants).find(@params[:event_id])
  end
end
