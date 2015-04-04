class TeamParticipant < ActiveRecord::Base
  belongs_to :event
  belongs_to :team
  belongs_to :participant

  has_one :event_score, dependent: :destroy

  validates :participant_id, presence: true
  validates :event_id,    presence: true
  validates :team_id,     presence: true

  delegate :category, to: :participant

  def self.for_category(category_id)
    joins(:participant).where(participants: { category_id: category_id })
  end

  def event_total
    EventScore.where(participant_id: participant_id).sum(:score)
  end
end
