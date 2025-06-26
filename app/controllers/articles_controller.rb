class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:success] = "Article '#{@article.title}' was successfully created!"
      redirect_to @article
    else
      flash.now[:error] = "There was an error creating the article."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      flash[:success] = "Article '#{@article.title}' was successfully updated!"
      redirect_to @article
    else
      flash.now[:error] = "There was an error updating the article."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    article_title = @article.title
    @article.destroy

    flash[:success] = "Article '#{article_title}' was successfully deleted!"
    redirect_to root_path, status: :see_other
  end

  private
  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end