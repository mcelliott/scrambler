class Flyer < ActiveRecord::Base
  belongs_to :user

  validates :name,  presence: true, length: { maximum: 50 }
  validates :user,  presence: true
  validates :hours, presence: true, numericality: true

  validates_numericality_of :hours, greater_than_or_equal_to: 0
end
