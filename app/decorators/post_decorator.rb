class PostDecorator < Cubisme::Decorator::Base
  def overview(options)
    content_tag :article, class: %w(post) do
      [header, excerpt].join.html_safe
    end
  end

  def suggested(options)
    content_tag :li do
      content = [
        link_to(record.title,
                post_path(year: record.published_at.year,
                          month: l(record.published_at.month),
                          id: record.slug, only_path: false))
      ]
      if options[:excerpt] == true
        content << content_tag(:p, record.excerpt, class: %w(excerpt))
      end
      content.join.html_safe
    end
  end

  protected

  def header
    content_tag :header, class: %w(post-header) do
      [
        content_tag(:span, time, class: %w(post-meta)),
        content_tag(:h2, link_to(record.title, post_path(record.published_at.year, record.published_at.month, record.slug)), class: %w(post-title))
      ].join.html_safe
    end
  end

  def time
    content_tag :time, l(record.published_at, format: :long), datetime: l(record.published_at, format: :short)
  end

  def excerpt
    content_tag :section, class: %w(post-excerpt) do
      content_tag :p, record.excerpt
    end
  end
end
