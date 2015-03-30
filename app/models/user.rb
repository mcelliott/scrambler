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

  has_many :participants, dependent: :destroy
  has_many :team_participants, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :flyers, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :event_scores, dependent: :destroy

  # validates :name, presence: true

  has_settings :current

  def password_required?
    !@skip_password && super
  end
end
