# frozen_string_literal: true

class ArticlesController < ApplicationController

  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article].inspect #Show what passed through the form
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save # if it passed our validation and saved do the following
      flash[:success] = 'Article was successfully created' # need an explanations
      redirect_to article_path(@article)
    else
      render 'new'
    end
    # @article.save --> save the article into the database
    # redirect_to article_path(@article) --> redirect to another page
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = 'Article was successfully updated'
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:danger] = 'Article was successfully deleted'
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:danger] = "You can only edit or delete your articles"
      redirect_to root_path
    end
  end
end
