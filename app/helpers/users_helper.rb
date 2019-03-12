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
          link_to "  remove as admin", admin_user_path(user),class: "btn btn-outline-danger float-right btn-sm " ,method: :delete 
      else 
          link_to "  set as admin",admin_user_path(user), class: "btn btn-outline-info float-right btn-sm ",method: :patch 
      end   
    end 
  end
end
