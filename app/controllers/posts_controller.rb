class PostsController < ApplicationController
  before_action :pagination, only: :index

  helper_method :posts

  def index
    respond_to do |format|
      format.html
      format.rss
    end
  end

  def show
    @post = Post.find_by_slug(params[:id])
    redirect_to :root and return if @post.nil?
    redirect_to :root and return unless @post.published?
  end

  protected

  def posts
    @posts ||= Post.published.order("published_at DESC").page(params[:page]).per(params[:per_page])
  end

  def pagination
    params[:per_page] ||= 10
    params[:page] ||= 1
  end
end
