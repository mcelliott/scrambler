class Event < ActiveRecord::Base
  has_many :participants, dependent: :destroy
  has_many :rounds, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :teams

  belongs_to :user

  validates :event_date, presence: true
  validates :location,   presence: true, length: { maximum: 50 }
  validates :user_id,       presence: true
  validates :name,       presence: true, length: { maximum: 50 }
  validates :team_size,  presence: true, numericality: true
  validates :num_rounds,     presence: true, numericality: true
  validates_numericality_of :team_size, greater_than_or_equal_to: 2

  monetize :participant_cost, allow_nil: false,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 10000
  }

  monetize :rate_per_minute, allow_nil: false,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 10000
  }

  def title
    "#{name} - #{event_date}"
  end

  def categories_participants
    participants.group_by { |p| p.category }
  end

  paginates_per 20
end
