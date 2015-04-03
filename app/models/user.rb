class User < ActiveRecord::Base
  enum role: [:user, :manager, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :invitable,
         :recoverable, :rememberable, :trackable, :validatable, :registerable

  has_settings :current

  def password_required?
    !@skip_password && super
  end
end
