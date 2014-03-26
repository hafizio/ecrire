module BlogHelper
  def navigation
    return if current_page? :root

    content_tag :nav, class: %w(site) do
      [
        image_tag('profile.jpg'),
        link_to('Articles', :root)
      ].join.html_safe
    end
  end
end
