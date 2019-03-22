module UsersHelper
  def gravatar_for(user,options = {size:80})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    img_size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?size=#{img_size}"


    image_tag(gravatar_url, alt: user.name)
  end

  def admin(user)
    if current_user != user
      if user.admin? 
          link_to "remove as admin", admin_user_path(user),class: "btn btn-outline-danger float-right btn-sm " ,method: :delete 
      else 
          link_to "set as admin",admin_user_path(user), class: "btn btn-outline-info float-right btn-sm ",method: :patch 
      end   
    end 
  end

  def count_learned_words
    @user = User.find(user)
    lesson = @user.lessons

    duplicate_category = lesson.group(:category_id).having('count(*) >= 2').pluck(:category_id)
    @duplicate_les = Lesson.where(category_id: duplicate_category,user_id: @user.id)
    dup_les = @duplicate_les.group_by{|n| n.category_id}
    @duplicate_lessons = dup_les.collect{|n| n.last.last}
    @non_duplicate_lesson = lesson.reject{|n| duplicate_category.include?(n.category_id)}
    @complete_lessons = (@non_duplicate_lesson << @duplicate_lessons).first

    @learned_words = @complete_lessons.collect{|n| n.answers}.size
  end

  def duplicate_lesson(user)
    lesson = user.lessons

    duplicate_category = lesson.group(:category_id).having('count(*) >= 2').pluck(:category_id)
    @duplicate_les = Lesson.where(category_id: duplicate_category,user_id: user.id)
    dup_les = @duplicate_les.group_by{|n| n.category_id}
    @duplicate_lessons = dup_les.collect{|n| n.last.last}
  end

  def latest_duplicate_lesson(user)
    lesson = user.lessons

    duplicate_category = lesson.group(:category_id).having('count(*) >= 2').pluck(:category_id)
    @duplicate_les = Lesson.where(category_id: duplicate_category,user_id: user.id)
    dup_les = @duplicate_les.group_by{|n| n.category_id}
    @duplicate_lessons = dup_les.collect{|n| n.last.last}
  end
end
