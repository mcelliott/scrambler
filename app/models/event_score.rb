class EventScore < ActiveRecord::Base
  validates :user_id, presence: true
  validates :round_id, presence: true
  validates :event_id, presence: true
  validates :team_participant_id, presence: true
  validates :score, presence: true

  belongs_to :user
  belongs_to :round
  belongs_to :event
  belongs_to :team_participant
end
