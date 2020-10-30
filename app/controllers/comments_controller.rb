class CommentsController < ApplicationController
  before_action :find_commentable
  
  def new
    @comment = Comment.new
  end

  def create
    if params[:article_id]
      @article = Article.find(params[:article_id])
    else
      @article = Comment.find(params[:comment_id]).article
    end
    if current_user
      @comment = @commentable.comments.new(comment_params)
      @comment.user = current_user
      @comment.article = @article
      @comment.save
      #@comment = @article.comments.create(comment_params)
      redirect_to article_path(@article)
    else
      redirect_to article_path(@article)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end

    def find_commentable
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = Article.find_by_id(params[:article_id]) if params[:article_id]
    end
  end