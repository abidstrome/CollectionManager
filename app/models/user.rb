class User < ApplicationRecord

  enum role: { user: 0, admin: 1 }
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
       self.role ||= :user
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :collections
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_items, through: :likes, source: :item

  def active_for_authentication?
    super && !blocked?
  end

  def inactive_message
    !blocked? ? super : :blocked
  end

  def liked?(item)

    liked_items.include?(item)

  end
 
end
