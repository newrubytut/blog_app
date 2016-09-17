class ArticlesController < ApplicationController
  before_filter :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @articles = Article.all
  end
  def new
  	@article = Article.new
  end

  def create
  	@article = current_user.articles.build(article_params)
  	if @article.save
  	 flash[:sucess] = "Article has been created"
  	 redirect_to articles_path
    else
      flash.now[:danger] = "Article has not been created"
      render :new
    end
  end

  def show
        
  end

  def update
    if @article.user != current_user
      flash[:danger] = "You can only edit your own article."
      redirect_to root_path
    else
      if @article.update(article_params)
        flash[:sucess]  = "Article has been updated"
        redirect_to @article
      else
        flash.now[:danger] = "Article not has been updated"
        render :edit
      end
    end
  end

  def edit
    if @article.user != current_user
      flash[:danger] = "You can only edit your own articles"
      redirect_to root_path
    end
  end

  def destroy
    if @article.destroy
      flash[:success] = "Article has been deleted"
      redirect_to articles_path
    end    
  end

  private
  	def article_params
  		params.require(:article).permit(:title, :body)
  	end

    def set_article
      @article = Article.find(params[:id])      
    end
end
