class Tenant < ActiveRecord::Base
  has_paper_trail
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

  def self.current_name
    current.name if current
  end

  def self.current_domain
    current.domain if current
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
