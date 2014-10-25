class Participant < ActiveRecord::Base

  belongs_to :category
  belongs_to :flyer
  belongs_to :event
  belongs_to :user

  delegate :name, to: :flyer

  validates :flyer,    presence: true
  validates :event,    presence: true
  validates :category, presence: true
  validates :user,     presence: true

end
