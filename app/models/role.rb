class Role < ActiveRecord::Base
  has_many :users
  has_enumeration_for :name, with: RoleType, create_helpers: { prefix: true }
  validates :name, presence: true, inclusion: { in: RoleType.list }

  def self.admin
    find_by(name: RoleType::ADMIN)
  end

  def self.user
    find_by(name: RoleType::USER)
  end

  def self.manager
    find_by(name: RoleType::MANAGER)
  end
end
