class Api::V2::PostsController < Api::V2::ApplicationController
  def index
    @posts = Post.all
    render json: @posts, status: :ok
  end

  def show
    @post = Post.find(params[:id])
    render json: @post, status: :ok
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: :ok
    else
      render json: @post.errors, status: :bad_request
    end
  end
end
