class Category < ActiveRecord::Base
  has_paper_trail
  has_many :teams, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 50 }, uniqueness: true
  validates :category_type, presence: true, inclusion: { in: CategoryType.list }

  has_enumeration_for :category_type, with: CategoryType, create_helpers: { prefix: true }

  def display_name
    name.humanize
  end
end
