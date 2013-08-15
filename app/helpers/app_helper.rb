module AppHelper
  def timeago(time)
    %(<time class="timeago" datetime="#{time}"></time>)
  end
  
  def user_name_tag(user)
    return '' if user.blank?
    %(<a href="">#{user.login}</a>)
  end
end