class LessonsController < ApplicationController

  def create 
    @category = Category.find(params[:category_id])
    @lesson = @category.lessons.build(lesson_params)
    @lesson.save
    
    @lesson.create_activity(user_id: @lesson.user_id)

    redirect_to new_lesson_answer_url(@lesson)
  end

  def show
    @lesson = Lesson.find(params[:id])
    @answers = @lesson.answers
  end

  private
    def lesson_params
      params.permit(:category_id,:user_id, :result)
    end

end
