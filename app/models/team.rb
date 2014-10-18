class Team < ActiveRecord::Base
  has_many :participants
  belongs_to :event
end
