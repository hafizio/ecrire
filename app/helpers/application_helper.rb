module ApplicationHelper
  def admin_navigation
    content_tag :header, id: 'adminNavigationOptions' do
      [
        menu.render,
        button_to(t("admin.navigation.logout"), session_path, method: :delete)
      ].join.html_safe
    end
  end

  def title
    return @post.title unless @post.nil?
    return "pothibo's blog"
  end

  def description_meta_tag
    content_tag :meta, nil, name: 'description', content: 'Ruby, Javascript, CSS blog. I use my experience to help you understand different programming concepts.'
  end

  def open_graph_type
    if @post.nil?
      'website'
    else
      'article'
    end
  end

  def admin_link
    return if current_user.nil?
    content_tag :li do
      link_to '&#9874;'.html_safe, admin_root_path, id: 'adminLink', class: %w(link icons)
    end
  end

  def logout_link
    return if current_user.nil?
    content_tag :li do
      button_to '&#59201;'.html_safe,
        session_path,
        method: :delete,
        class: %w(icons link),
        form_class: %w(logout)
    end
  end

end
