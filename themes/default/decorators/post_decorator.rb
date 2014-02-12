class PostDecorator < EcrireDecorator

  def overview(html_options)
    html_options[:id] = "post-#{record.id}"
    html_options[:class] ||= %w(post)
    content_tag :article, html_options do
      [
        title,
        published_at
      ].join.html_safe
    end
  end

  protected

  def title
    content_tag :h3 do
      link_to record.title, post_path(record.published_at.year, l(record.published_at, format: "%m"), record, trailing_slash: true)
    end
  end

  def published_at
    content_tag :span, l(record.published_at.to_date, format: :long), class: %w(timestamp)
  end

end

