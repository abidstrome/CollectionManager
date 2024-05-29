class Item < ApplicationRecord
  belongs_to :collection
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_by_users, through: :likes, source: :user
  validates :name, presence: true
  validates :collection, presence: true
  acts_as_taggable_on :tags
  include PgSearch::Model
  pg_search_scope :search_by_name_comments_and_tags,
                   against: [:name],
                   associated_against: { tags: :name, comments: :body},
                   using: { tsearch: { prefix: true } }

                
end
