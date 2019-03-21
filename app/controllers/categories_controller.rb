class CategoriesController < ApplicationController
  def index
    @lessons = Lesson.where(user_id: current_user.id)
    @status = params[:status]

    duplicate_category = @lessons.group(:category_id).having('count(*) >= 2').pluck(:category_id)
    @duplicate_les = Lesson.where(category_id: duplicate_category,user_id: current_user)
    @latest_duplicate = @duplicate_les.order(:created_at).last
    @non_duplicate_lesson = @lessons.reject{|n| duplicate_category.include?(n.category_id)}
    @complete_lessons = @non_duplicate_lesson << @latest_duplicate
# abort
    all_cats = Category.all
    learned_cats = @complete_lessons.collect{|n| n.category}
    
    # abort
    if @status == "unlearned"
      @cats = (all_cats - learned_cats).paginate(page: params[:page], per_page: 6)
    elsif @status == "learned"
      @cats = learned_cats.paginate(page: params[:page], per_page: 6)
    else
      @cats = all_cats.paginate(page: params[:page], per_page: 6)
    end
  end
end
