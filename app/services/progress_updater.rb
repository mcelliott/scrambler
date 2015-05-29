class ProgressUpdater
  attr_accessor :event

  def initialize(event)
    @event = event
  end

  def update(pct)
    $redis.set(key, pct)
  end

  def status
    $redis.get(key) || 0
  end

  private

  def key
    "event-#{event.id}"
  end
end