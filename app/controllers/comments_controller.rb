class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, only: [:edit, :update, :destroy]
  
  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:success] = "Comment was successfully updated!"
      redirect_to @article
    else
      flash.now[:error] = "There was an error updating the comment."
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @comment = @article.comments.build(comment_params)
    
    if @comment.save
      flash[:success] = "Comment was successfully added!"
    else
      flash[:error] = "There was an error adding your comment."
    end
    
    redirect_to article_path(@article)
  end

  def destroy
    @comment.destroy
    flash[:success] = "Comment was successfully deleted!"
    redirect_to article_path(@article), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :status)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  end
end