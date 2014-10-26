class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many   :teams, dependent: :destroy

  validates :event, presence: true
  validates :user,  presence: true
  validates :round_number, presence: true
end
