class Team < ActiveRecord::Base
  has_many :participants
  belongs_to :event

  belongs_to :user
  belongs_to :category
end
