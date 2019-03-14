class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :category 
  has_many :answers 
  has_many :words, through: :answers
  has_many :choices, through: :answers
  
  
  accepts_nested_attributes_for :answers

  def count_correct_answer
    choices.where(correct: true).count
  end
end
