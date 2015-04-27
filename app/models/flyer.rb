class Flyer < ActiveRecord::Base
  has_paper_trail
  before_validation :downcase_email

  has_enumeration_for :hours, with: TunnelHours, create_helpers: { prefix: true }

  validates_uniqueness_of :email
  validates :name,  presence: true, length: { maximum: 50 }
  validates :hours, inclusion: TunnelHours.list, allow_blank: false
  validates_numericality_of :hours, greater_than_or_equal_to: 0
  paginates_per 20

  private

  def downcase_email
    self.email = self.email.downcase if self.email.present?
  end
end
