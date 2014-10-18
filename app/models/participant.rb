class Participant < ActiveRecord::Base
  belongs_to :skill
  belongs_to :team
  belongs_to :flyer
  belongs_to :event
end
