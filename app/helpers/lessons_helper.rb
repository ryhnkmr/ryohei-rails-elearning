module LessonsHelper
  def count_words(id)
    Word.where(category_id: id).count
  end

  
end
