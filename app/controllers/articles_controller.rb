class ArticlesController < ApplicationController

  def index
    @articles = Article.all
    render :index
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_url
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  
  def article_params
    params.require(:article).permit(:title, :body)
  end 

end
