class PostsController < ApplicationController

  #Filters
  #Set instance variable @post before action perform
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    if params[:counter].present?
      @posts = Post.offset(params[:counter].to_i * 10).limit(10)
      render partial: 'index' and return
    else
      @posts = Post.limit(10)
      @counter = Post.count/10
    end
  end

  def show
  end

  def new
    @post = Post.new()
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      flash[:error] = @post.errors
      render :new
    end
  end

  def edit
  end
  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      flash[:error] = @post.errors
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end


  private

  #Whitlist parameters before pass them to model
  def post_params
    params.require(:post).permit(:title, :category_id)
  end

  #Set post finding by it's id
  def set_post
    @post = Post.find(params[:id])
  end
end
