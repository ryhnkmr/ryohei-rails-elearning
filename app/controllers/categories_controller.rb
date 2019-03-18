class CategoriesController < ApplicationController
  def index
    @lessons = Lesson.where(user_id: current_user.id)
    @lessons_category = @lessons.collect{|n| n.category_id}
    @status = params[:status]

    all_cats = Category.paginate(page: params[:page], per_page: 6)
    learned_cats = @lessons.collect{|n| n.category}

    if @status == "all"
      @cats = all_cats
    elsif @status == "learned"
      @cats = learned_cats
    else
      @cats = (all_cats - learned_cats)  
    end
  end
end
