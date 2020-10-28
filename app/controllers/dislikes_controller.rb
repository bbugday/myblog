class DislikesController < ApplicationController
  before_action :find_article
  before_action :find_dislike, only: [:destroy]

  def create
    if already_disliked?
      flash[:notice] = "You can't dislike more than once"
    else
      @article.dislikes.create(user_id: current_user.id)
    end
    redirect_to article_path(@article)
  end

  def destroy
    if !(already_disliked?)
      flash[:notice] = "Cannot undo dislike"
    else
      @dislike.destroy
    end
    redirect_to article_path(@article)
  end

  private
  def already_disliked?
    Dislike.where(user_id: current_user.id, article_id:
    params[:article_id]).exists?
  end

  def find_article
    @article = Article.find(params[:article_id])
  end

  def find_dislike
    @dislike = @article.dislikes.find(params[:id])
 end
end