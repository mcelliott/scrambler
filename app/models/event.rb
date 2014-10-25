class Event < ActiveRecord::Base
  has_many :participants
  has_many :teams

  belongs_to :user

  validates :event_date, presence: true
  validates :location,   presence: true, length: { maximum: 50 }
  validates :user,       presence: true
  validates :name,       presence: true, length: { maximum: 50 }
  validates :team_size,  presence: true, numericality: true
  validates :rounds,     presence: true, numericality: true

  validates_numericality_of :team_size, greater_than_or_equal_to: 2
  validates_numericality_of :team_size, greater_than: 0
end
