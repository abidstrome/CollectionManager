class Collection < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :items, dependent: :destroy
  validates :name, :description, :category_id, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_name_or_description,
                  against: [:name, :description],
                  using: {
                    tsearch: {prefix: true}
                  }
                

  def any_item
    items.first
  end
end
