class LessonsController < ApplicationController

  def create 
    # @lesson = Lesson.new(lesson_params)
    @category = Category.find(params[:category_id])
    # @user  = User.find(params[:user_id])
    @lesson = @category.lessons.build(lesson_params)
    @lesson.save

    redirect_to new_lesson_answer_url(@lesson)
  end

  private
    def lesson_params
      params.permit(:category_id,:user_id, :result)
    end

end
