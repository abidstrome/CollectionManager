class Collection < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :items, dependent: :destroy
  validates :name, :description, :category_id, presence: true
                
end
