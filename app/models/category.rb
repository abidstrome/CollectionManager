class Category < ApplicationRecord
    has_many :collections

    validates :name, presence: true, uniqueness: true
end
