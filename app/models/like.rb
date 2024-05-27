class Like < ApplicationRecord
  belongs_to :user
  belongs_to :item
  validates :user_id, uniqueness: {scope: :item_id, message: "can only like an item once"}
end
