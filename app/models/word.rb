class Word < ApplicationRecord
  belongs_to :category

  has_many :choices,
            dependent: :destroy
  has_many :answers
  has_many :lessons ,through: :answers,
            dependent: :destroy
  accepts_nested_attributes_for :choices
  


  validates :content, presence: true
  validate :check_box

  def correct_answer
    choices.find_by(correct: true)
  end

  

  private
    def check_box
      choices_correct = choices.collect{|choice| choice.correct || nil }
      errors.add(:choices, "Check only one box") if choices_correct.compact.size != 1
    end
end
