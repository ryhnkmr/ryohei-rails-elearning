class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :category 
  has_many :answers 
  has_many :words, through: :answers,
                  dependent: :destroy
  
  
  accepts_nested_attributes_for :answers
end
