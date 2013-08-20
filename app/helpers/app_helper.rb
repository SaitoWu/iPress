module AppHelper
  def timeago(time)
    %(<time class="timeago" datetime="#{time}"></time>)
  end
  
  def user_name_tag(user)
    return '' if user.blank?
    %(<a href="#{path_to 'users#show', user.login}">#{user.login}</a>)
  end
  
  def paginate(scope)
    page = ['<ul class="pagination">']
    total_pages = scope.total_pages
    current_page = (params[:page] || "1").to_i
    page << "<li class='previous #{current_page == 1 ? 'disabled' : ''}'><a href='#{request.path}?page=#{[current_page-1,1].max}'>&laquo; 上一页</a></li>"
    (1..total_pages).each do |n|
      page << "<li class='#{current_page == n ? 'active' : ''}'><a href='#{request.path}?page=#{n}'>#{n}</a></li>"
    end
    page << "<li class='next #{current_page == total_pages ? 'disabled' : ''}'><a href='#{request.path}?page=#{[current_page+1,total_pages].min}'>下一页 &raquo;</a></li>"
    page << "</ul>"
    page.join
  end
end