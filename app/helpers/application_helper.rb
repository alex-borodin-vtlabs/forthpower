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
    src = if user.avatar_url
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
end
