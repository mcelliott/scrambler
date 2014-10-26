class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :participants, dependent: :destroy
  has_many :team_participants, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :flyers, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :teams, dependent: :destroy
end
