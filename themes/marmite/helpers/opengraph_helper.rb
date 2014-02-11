module OpengraphHelper

  def og_article(post)
    raise OGNoArticleError if post.nil?
    [
      og_title,
      og_type('article'),
      og_image(post),
      content_tag(:meta, nil, property: 'article:published_time', content: post.published_at.iso8601),
      content_tag(:meta, nil, property: 'og:url', content: request.url),
      content_tag(:meta, nil, property: 'og:description', content: Rails.configuration.meta.description)
    ].join.html_safe
  end

  def og_image(post)
    return unless post.images.count > 0
    content_tag :meta, nil, property: 'og:image', content: post.images.last.url
  end
end
