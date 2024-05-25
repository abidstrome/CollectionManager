class Collection < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :items, dependent: :destroy
  validates :name, :description, :category_id, presence: true

  attr_accessor :custom_bool1_state, :custom_bool1_name,
                :custom_bool2_state, :custom_bool2_name,
                :custom_bool3_state, :custom_bool3_name,
                :custom_date1_state, :custom_date1_name,
                :custom_date2_state, :custom_date2_name,
                :custom_date3_state, :custom_date3_name,
                :custom_text1_state, :custom_text1_name,
                :custom_text2_state, :custom_text2_name,
                :custom_text3_state, :custom_text3_name

                
end
