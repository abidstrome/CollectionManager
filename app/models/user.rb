class User < ApplicationRecord

  enum role: { user: 0, admin: 1 }
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
       self.role ||= :user
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :collections

  def active_for_authentication?
    super && !blocked?
  end

  def inactive_message
    !blocked? ? super : :blocked
  end
 
end
