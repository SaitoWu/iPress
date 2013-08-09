module AppHelper
  def timeago(time)
    %(<time class="timeago" datetime="#{time}"></time>)
  end
  
  def user_name_tag(user)
    return '' if user.blank?
    # %(<a href="#{path_to 'users#show', user.login}">#{user.login}</a>)
  end
end