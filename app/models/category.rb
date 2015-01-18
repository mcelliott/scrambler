class Category < ActiveRecord::Base
  has_many :teams, dependent: :destroy
  belongs_to :user

  validates :name,  presence: true, length: { maximum: 50 }
  validates :user,  presence: true
end
