class Choice < ApplicationRecord
  belongs_to :word

  validates :content, presence:true
 

  


end
