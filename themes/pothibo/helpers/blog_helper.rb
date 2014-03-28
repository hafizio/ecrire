module BlogHelper
  def navigation
    return if current_page? :root

    content_tag :nav, class: %w(site) do
      [
        image_tag('profile.jpg'),
        link_to('Articles', :root),
        content_tag(:div, nil, class: %w(spacer)),
        mailing_list_form
      ].join.html_safe
    end
  end

  private

  def mailing_list_form
    form_tag "http://pothibo.us4.list-manage.com/subscribe/post?u=c1a7606ebf0d844b14ef03fdf&amp;id=a0ae11323b", method: "post", target: "_blank" do
      [
        email_field_tag(:EMAIL, nil, placeholder: "Subscribe to the mailing list"),
        button_tag("Subscribe")
      ].join.html_safe
    end
  end
end
