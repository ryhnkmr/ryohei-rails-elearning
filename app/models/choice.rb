class Choice < ApplicationRecord
  belongs_to :word
  has_many :answers,
            dependent: :destroy
  has_many :lessons ,through: :answers

  validates :content, presence:true
 

  


end
