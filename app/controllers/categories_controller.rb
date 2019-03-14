class CategoriesController < ApplicationController
  def index
    @cats = Category.paginate(page: params[:page], per_page: 6)
    @lessons = Lesson.where(user_id: current_user.id)
    @lessons_category = @lessons.collect{|n| n.category_id}
  end
end
