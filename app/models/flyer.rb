class Flyer < ActiveRecord::Base
  has_enumeration_for :hours, with: TunnelHours, create_helpers: { prefix: true }

  validates :name,  presence: true, length: { maximum: 50 }
  validates :hours,  inclusion: TunnelHours.list, allow_blank: false

  validates_numericality_of :hours, greater_than_or_equal_to: 0
  validates :email, email: true

  paginates_per 20
end
