class WordsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    lesson = @user.lessons
    
    @title = params[:title]
    @previous_lesson = params[:previous]

    duplicate_category = lesson.group(:category_id).having('count(*) >= 2').pluck(:category_id)
    @duplicate_les = Lesson.where(category_id: duplicate_category,user_id: @user.id)
    dup_les = @duplicate_les.group_by{|n| n.category_id}
    @duplicate_lessons = dup_les.collect{|n| n.last.last}
    @non_duplicate_lesson = lesson.reject{|n| duplicate_category.include?(n.category_id)}.flatten
    @complete_lessons = (@non_duplicate_lesson << @duplicate_lessons).flatten

    @cats = @complete_lessons.collect{|n| n.category}.flatten
    
    if @previous_lesson != nil
      @answers = Answer.where(lesson_id: @previous_lesson.to_i)
    else
      if @title == "all" || @title == nil
        @answers = @complete_lessons.collect{|n| n.answers}.flatten.paginate(page: params[:page], per_page: 10)
      else
        lesson = @complete_lessons.select{|n| n.category_id == @title.to_i}
        @answers = lesson.collect{|n| n.answers}.flatten.paginate(page: params[:page], per_page: 10)
      end
    end
  end
end