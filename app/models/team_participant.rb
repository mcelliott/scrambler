class TeamParticipant < ActiveRecord::Base
  belongs_to :event
  belongs_to :team
  belongs_to :participant
  belongs_to :user

  has_one :event_score, dependent: :destroy

  validates :participant, presence: true
  validates :event,       presence: true
  validates :team,        presence: true
  validates :user,        presence: true

  def event_total
    EventScore.where(participant_id: participant_id).sum(:score)
  end
end
