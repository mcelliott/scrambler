class TeamParticipant < ActiveRecord::Base
  belongs_to :event
  belongs_to :team
  belongs_to :participant
  belongs_to :user

  validates :participant, presence: true
  validates :event,       presence: true
  validates :team,        presence: true
  validates :user,        presence: true

end
