class Handicap < ActiveRecord::Base
  has_paper_trail
  has_enumeration_for :hours, with: TunnelHours, create_helpers: { prefix: true }

  validates :hours, presence: true
  validates_inclusion_of :hours, in: TunnelHours.list
  validates :amount, presence: true, numericality: true
end
