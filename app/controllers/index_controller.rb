class IndexController < ApplicationController
  def index
    @posts = Post.reversed.all.to_a
  end
end
