class Word < ApplicationRecord
  belongs_to :category

  has_many :choices,
            dependent: :destroy
  accepts_nested_attributes_for :choices

  validates :content, presence: true
  validate :check_box

  private
    def check_box
      choices_correct = choices.collect{|choice| choice.correct || nil }
      errors.add(:choices, "Check only one box") if choices_correct.compact.size != 1
    end
end
