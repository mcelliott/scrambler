class Tenant < ActiveRecord::Base
  validates :name,
            presence: true,
            uniqueness: true
  validates :domain,
            format: { with: /\A[a-z0-9\-]+\Z/ },
            presence: true,
            uniqueness: true
  validates :database,
            format: { with: /\A[a-z0-9_]+\Z/ },
            presence: true,
            uniqueness: true

  def self.current
    find_by(database: Apartment::Tenant.current)
  end

  def switch!
    Apartment::Tenant.switch(database)
  end

  def enable!
    update(enabled: true)
  end

  def disable!
    update(enabled: false)
  end

  has_settings :current
end
