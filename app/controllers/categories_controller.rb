class CategoriesController < ApplicationController
  def index
    @lessons = Lesson.where(user_id: current_user.id)
    @status = params[:status]
    @user = User.find(current_user.id)
    lesson = @user.lessons

    duplicate_category = @lessons.group(:category_id).having('count(*) >= 2').pluck(:category_id)
    @duplicate_les = Lesson.where(category_id: duplicate_category,user_id: current_user)
    dup_les = @duplicate_les.group_by{|n| n.category_id}
    @duplicate_lessons = dup_les.collect{|n| n.last.last}.flatten
    @non_duplicate_lesson = lesson.reject{|n| duplicate_category.include?(n.category_id)}.flatten
    @complete_lessons = (@non_duplicate_lesson << @duplicate_lessons).flatten
    
# abort
    @all_cats = Category.all
    
    if @all_cats.size != 0    
      if @lessons.size != 0
        learned_cats = @complete_lessons.collect{|n| n.category}
        if @status == "unlearned"
          @cats = (@all_cats - learned_cats).paginate(page: params[:page], per_page: 6)
        elsif @status == "learned"
          @cats = learned_cats.paginate(page: params[:page], per_page: 6)
        else
          @cats = @all_cats.paginate(page: params[:page], per_page: 6)
        end
      else
        @cats = @all_cats.paginate(page: params[:page], per_page: 6)
      end
    end 
  end
end
