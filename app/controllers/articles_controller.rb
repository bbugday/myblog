class ArticlesController < ApplicationController
	before_action :find_article, only: [:show, :edit, :update, :destroy]
	def index
		@articles = Article.all
		@tags = Tag.all
  end

	def show
		@article = Article.find(params[:id])
		@tags = Tag.all
	end
	
	def new
		@article = Article.new
  end
 
	def edit
		@article = Article.find(params[:id])
	end
	
	def create
		@article = Article.new(article_params)
		@article.user = current_user
		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end
	
	def destroy
		@article = Article.find(params[:id])
		if @article.user == current_user
			@article.destroy
			redirect_to articles_path
		else
			redirect_to articles_path
		end
	end
	
	private
		def find_article
			@article = Article.find(params[:id])
		end
		def article_params
			params.require(:article).permit(:title, :text, :cover,:tag_list)
		end
	end