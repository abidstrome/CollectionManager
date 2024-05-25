class Item < ApplicationRecord
  belongs_to :collection
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :name, presence: true
  validates :collection, presence: true
  acts_as_taggable_on :tags
  include PgSearch::Model
  pg_search_scope :search_by_name_and_tags,
                   against: [:name, :tags],
                   using: { tsearch: { prefix: true } }

  attr_accessor :custom_text1, :custom_text2, :custom_text3,
                :custom_bool1, :custom_bool2, :custom_bool3,
                :custom_date1, :custom_date2, :custom_date3
                
end
