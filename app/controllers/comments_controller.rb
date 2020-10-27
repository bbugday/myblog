class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    if current_user
      @comment = Comment.new(comment_params)
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
  end