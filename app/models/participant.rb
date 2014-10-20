class Participant < ActiveRecord::Base
  belongs_to :category
  belongs_to :team
  belongs_to :flyer
  belongs_to :event
  belongs_to :user

  validates :flyer, presence: true
  validates :event, presence: true
end
