class Team < ActiveRecord::Base
  has_many :team_participants
  belongs_to :event

  belongs_to :user
  belongs_to :category

  validates :name,      presence: true, length: { maximum: 50 }
  validates :category,  presence: true
  validates :event,     presence: true

end
