class Handicap < ActiveRecord::Base
  has_enumeration_for :hours, with: TunnelHours, create_helpers: { prefix: true }
  belongs_to :user
end
