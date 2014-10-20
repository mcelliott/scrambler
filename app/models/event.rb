class Event < ActiveRecord::Base
  has_many :participants
  has_many :teams

  belongs_to :user
end
