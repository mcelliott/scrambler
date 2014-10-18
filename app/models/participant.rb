class Participant < ActiveRecord::Base
  belongs_to :category
  belongs_to :team
  belongs_to :flyer
  belongs_to :event

  validates :flyer, presence: true
  validates :event, presence: true
end
