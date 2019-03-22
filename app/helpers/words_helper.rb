module WordsHelper
  def count_learned_words(user)
    lesson = user.lessons

    duplicate_category = lesson.group(:category_id).having('count(*) >= 2').pluck(:category_id)
    @duplicate_les = Lesson.where(category_id: duplicate_category,user_id: user)
    dup_les = @duplicate_les.group_by{|n| n.category_id}
    @duplicate_lessons = dup_les.collect{|n| n.last.last}
    @non_duplicate_lesson = lesson.reject{|n| duplicate_category.include?(n.category_id)}
    @complete_lessons = (@non_duplicate_lesson << @duplicate_lessons).flatten

    @learned_words = @complete_lessons.collect{|n| n.answers}.flatten.size
  end
end
