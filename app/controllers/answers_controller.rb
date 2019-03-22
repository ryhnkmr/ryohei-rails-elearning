class AnswersController < ApplicationController
  def new
    @lesson = Lesson.find(params[:lesson_id])
    @cat = Category.find(@lesson.category_id)
    learning_word = @cat.words
    learned_word = @lesson.words

    if (learning_word - learned_word).size != 0
      @word = (learning_word - learned_word).first
    else
      # @lesson.update(result: @cat.)
      redirect_to lesson_url(@lesson)
    end
    
  end

  def create
    lesson  = Lesson.find(params[:lesson_id])
    choice = Choice.find(params[:answer][:choice_id])
    word  =Word.find(params[:answer][:word_id])
    answer = lesson.answers.build(answer_params)
    
    answer.save
    redirect_to new_lesson_answer_url(lesson)

  end

  private
    def answer_params
      params.require(:answer).permit(:choice_id,:word_id, :lesson_id)
    end



end