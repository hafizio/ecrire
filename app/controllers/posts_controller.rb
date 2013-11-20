class PostsController < ApplicationController
  before_action :pagination, only: :index

  def index
    @posts = Post.published.order("published_at DESC").page(params[:page]).per(params[:per_page])
    respond_to do |format|
      format.html
      format.rss
    end
  end

  def show
    @post = Post.find_by_slug(params[:id])
    redirect_to :root and return if @post.nil?
    redirect_to :root and return unless @post.published?

    if params[:bouncing].eql? "true"
      finished('posts_suggestion')
    end
    view = ab_test 'posts_suggestion', 'sidebar', 'bottom'
    render "posts/splits/show/#{view}" and return
  end

  protected

  def pagination
    params[:per_page] ||= 10
    params[:page] ||= 1
  end
end
