class CategoriesController < ApplicationController
  def index
    @lessons = Lesson.where(user_id: current_user.id)
    @lessons_category = @lessons.collect{|n| n.category_id}
    @status = params[:status]
abort
    all_cats = Category.all
    learned_cats = @lessons.collect{|n| n.category}
    
    # abort
    if @status == "all"
      @cats = all_cats.paginate(page: params[:page], per_page: 6)
    elsif @status == "learned"
      @cats = learned_cats.paginate(page: params[:page], per_page: 6)
    else
      @cats = (all_cats - learned_cats).paginate(page: params[:page], per_page: 6)
    end
  end
end
