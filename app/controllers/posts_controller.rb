class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  caches_action :index, cache_path: proc {|c| first_patient = Post.select(:id, :updated_at).first; { format: c.request.format.symbol, updated_at: first_patient.try(:updated_at), id: first_patient.try(:id)} }
  caches_action :show, cache_path: proc { |c| {format: c.request.format.symbol, updated_at: Post.select(:updated_at).find(c.params[:id]).updated_at}}
  respond_to :html, :json

  def index
    @posts = Post.all
    respond_with(@posts)
  end

  def show
    respond_with(@post)
  end

  def new
    @post = Post.new
    respond_with(@post)
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.save
    respond_with(@post)
  end

  def update
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    @post.destroy
    respond_with(@post)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
