class User < ActiveRecord::Base
  has_paper_trail
  belongs_to :role
  before_create :set_default_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :invitable,
         :recoverable, :rememberable, :trackable, :validatable, :registerable

  has_settings :current

  scope :general, -> { where.not(role: Role.admin) }

  def password_required?
    !@skip_password && super
  end

  def role_name
    role.try(:name)
  end

  private

  def set_default_role
    self.role ||= Role.find_by_name('user')
  end
end
