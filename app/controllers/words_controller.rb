class WordsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    lesson = @user.lessons
    # abort
    @cats = lesson.collect{|n| n.category}
    # @answers = lesson.collect{|n| n.answers}
    @title = params[:title]

    # @answers = @user.answers
    # abort
    # end
    if @title == "all" || @title == nil
      @answers = @user.answers
      # abort 
    else
      lesson = Lesson.where(user_id: @user.id).where(category_id: @title)
      @answers = lesson.collect{|n| n.answers.first}
    end
  end
end