json.posts @posts do |post|
  json.title post.title
  json.url post_path(post.published_at.year, post.published_at.month, post.slug, only_path: false)
  json.published_at post.published_at
end
