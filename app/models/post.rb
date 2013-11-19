class Post < ActiveRecord::Base
  scope :status, lambda {|status|
    if status.eql?("published")
      where "posts.published_at IS NOT NULL"
    else
      where "posts.published_at IS NULL"
    end
  }

  scope :published, lambda { status("published") }
  scope :drafted, lambda { status("drafted") }
  scope :slug, lambda { |slug| where("posts.slug is ?", slug) }

  validates :title, presence: true
  validates :slug, presence: true, on: :update

  before_create :create_slug_if_nil
  before_save :generate_excerpt

  def status=(new_status)
    if new_status.eql? "publish"
      publish!
    end
  end

  def publish!
    return unless published_at.nil?
    self.published_at = DateTime.now
    save!
  end

  def published?
    !draft?
  end

  def draft?
    published_at.nil?
  end

  def to_param
    slug
  end

  protected

  def create_slug_if_nil
    return unless self.slug.blank?
    self.slug = self.title.parameterize
  end

  def generate_excerpt
    html = Nokogiri::HTML(self.content).xpath("//body").children
    self.excerpt = html.children.to_a.join(" ")[0..75] << "..."
  end
end
