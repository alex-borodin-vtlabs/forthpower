module ApplicationHelper

  def flash_class(level)
    case level.to_sym
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-danger"
    when :alert then "alert alert-warning"
    end
  end

  def gravatar_for(user, opts = {})
    opts[:alt] = user.name
    src = if user.avatar_url?
      user.avatar_url
    else
      "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{opts.delete(:size) { 50 }}"
    end
    image_tag src,
              opts
  end

  def resource_name
     :user
   end

   def resource_class
      User
   end

   def resource
     @resource ||= User.new
   end

   def devise_mapping
     @devise_mapping ||= Devise.mappings[:user]
   end

   def nav_link(link_text, link_path)
     class_name = current_page?(link_path) ? 'active' : ''
     content_tag(:li, class: "nav-item #{class_name}") do
       link_to link_text, link_path, class: "nav-link"
     end
   end

   def preview_user_text(user)
     strip_tags(user.bio.to_s).truncate(100)
   end
end
