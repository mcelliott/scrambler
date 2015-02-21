class Team < ActiveRecord::Base
  has_many :team_participants, dependent: :destroy
  belongs_to :event
  belongs_to :round
  belongs_to :user
  belongs_to :category

  validates :name,      presence: true, length: { maximum: 50 }
  validates :category,  presence: true
  validates :event,     presence: true
  validates :round,     presence: true

  def has_space?
    team_participants.size < event.team_size
  end

  def size
    team_participants.size
  end

  def self.for_category(category_id)
    where(category_id: category_id)
  end
end

