class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true
  validates :slug, presence: true
  validates :title, presence: true
end
