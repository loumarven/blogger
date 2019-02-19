class ArticlesController < ApplicationController
  include ArticlesHelper

  before_action :require_login, except: [:index, :show]

  def index
    @articles = Article.all.order(created_at: :desc)
  end

  def show
    @article = Article.find(params[:id])

    @comment = Comment.new
    @comment.article_id = @article.id

    @article.update_column(:view_count, @article.update_view_count)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.author = current_user.username
    @article.view_count = 0
    @article.save

    flash.notice = "Article #{@article.title} created!"

    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])

    if @article.author == current_user.username
      @article.destroy

      flash.notice = "Article #{@article.title} deleted!"

      redirect_to articles_path
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update 
    @article = Article.find(params[:id])

    if @article.author == current_user.username
      @article.update(article_params)

      flash.notice = "Article #{@article.title} updated!"

      redirect_to article_path(@article)
    end
  end
end
