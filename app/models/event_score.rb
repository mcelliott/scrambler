class EventScore < ActiveRecord::Base
  validates :user_id, presence: true
  validates :round_id, presence: true
  validates :event_id, presence: true
  validates :team_participant_id, presence: true
  validates :score, presence: true
  validates :participant_id, presence: true

  belongs_to :user
  belongs_to :round
  belongs_to :event
  belongs_to :participant
  belongs_to :team_participant
end
