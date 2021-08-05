class Api::CommentsController < ApplicationController

  before_action :find_article, only: [:create, :index]


  def create
    begin
      comment = Comment.new
      comment.user = @current_user
      comment.article = @article
      comment.attributes = new_comment_permit_params
      if comment.save!
        render json: { succes: 'Comment is created' }, status: 201
      end

    rescue => e
      render json: { error: e }, status: 400
    end
  end


  def index
    begin
      render json: {comments: Comment.where(article: @article)}
    rescue => e
      render json: { error: e }, status: 400
    end
  end


  def destroy
    begin
      comment = Comment.find(permit_comment_id[:id])
      if comment.user == @current_user
        if comment.destroy!
          render json: { succes: 'Comment is deleted' }, status: 200
        end
      else
        render json: { error: 'Access denied. Removal is available only to the author' }, status: 403
      end

    rescue => e
      render json: { error: e }, status: 400
    end
  end


  private


  def new_comment_permit_params
    params.permit(:body)
  end

  def permit_comment_id
    params.permit(:id)
  end

  def permit_article_id
    params.permit(:article_id)
  end

  def find_article
    @article = Article.find(permit_article_id[:article_id])
  end


end
