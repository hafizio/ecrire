module OpengraphHelper

  def og_article(post)
    raise OGNoArticleError if post.nil?
    [
      og_title,
      og_type('article'),
      og_image(post),
      content_tag(:meta, nil, property: 'og:article:published_time', content: post.published_at.iso8601)
    ].join.html_safe
  end

  def og_image(post)
    return unless post.images.count > 0
    content_tag :meta, nil, property: 'og:image', content: post.images.last.url
  end
end
