class Pothibo::PostsController < PostsController
  def index
    @posts = Post.all
  end
end
