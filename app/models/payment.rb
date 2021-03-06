class Payment < ActiveRecord::Base
  belongs_to :event
  belongs_to :participant

  validates :event_id, presence: true
  validates :participant_id, presence: true
end
