class Category < ApplicationRecord
  has_many :words,
            dependent: :destroy
  accepts_nested_attributes_for :words
  has_many :lessons
  has_many :answers, through: :lesson

  validates :title, presence: true
  validates :description, presence: true

end
