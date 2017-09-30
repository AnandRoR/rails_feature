class CategoriesController < ApplicationController


  #Filters
  #Set instance variable @post before action perform
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
  	@posts = Post.all
  end

  def show
  end

  def new
  	post = Post.find(params[:id])
    @comment = post.comments.new()
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to comments_path
    else
      flash[:error] = @comment.errors
      render :new
    end
  end

  def edit
  end
  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post)
    else
      flash[:error] = @comment.errors
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  
  private

  #Whitlist parameters before pass them to model
  def comment_params
    params.require(:comment).permit(:message )
  end

  #Set comment finding by it's id
  def set_comment
    @comment = Comment.find(params[:id])
    @post = @comment.post
  end
end
