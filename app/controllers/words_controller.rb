class WordsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    lesson = @user.lessons
    @cats = lesson.collect{|n| n.category}
    @title = params[:title]

    if @title == "all" || @title == nil
      @answers = @user.answers
    else
      lesson = Lesson.where(user_id: @user.id).where(category_id: @title)
      @answers = lesson.collect{|n| n.answers.first}
    end
  end
end