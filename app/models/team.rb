class Team < ActiveRecord::Base
  has_many :team_participants, dependent: :destroy
  belongs_to :event
  belongs_to :round
  belongs_to :category

  validates :name, presence: true, length: { maximum: 50 }
  validates :category_id,  presence: true
  validates :event_id,     presence: true
  validates :round_id,     presence: true

  default_scope { order('created_at') }

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

