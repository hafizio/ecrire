module DefaultHelper
  def body_tag(html_options = {})
    html_options[:id] = [controller_name, action_name].join('-')
    super
  end
end
