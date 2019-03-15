class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :category 
  has_many :answers 
  has_many :words, through: :answers
  has_many :choices, through: :answers
  has_one :activity, as: :action
  
  
  accepts_nested_attributes_for :answers

  def count_correct_answer
    choices.where(correct: true).count
  end

  def lesson_action

  end
end
