class Category < ApplicationRecord
  has_many :words,
            dependent: :destroy
  accepts_nested_attributes_for :words
end
