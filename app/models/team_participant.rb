class TeamParticipant < ActiveRecord::Base
  belongs_to :event
  belongs_to :team
  belongs_to :participant
  belongs_to :user
end
