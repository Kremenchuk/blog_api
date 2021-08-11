class Api::ArticlesController < ApplicationController

  before_action :find_article, only: [:show, :destroy]

  rescue_from ActiveRecord::RecordInvalid, with: ->(error) do
    render json: { error: error }, status: 400
  end

  def create
      article = Article.new
      article.user = @current_user
      article.attributes = new_article_permit_params
      article.save!
      render json: { succes: 'Article is created' }, status: 200
  end


  def index
      articles = Article.all
      render json: {articles: add_comments_count_to_response(articles)}, status: 200
  end



  def show
      if @article.present?
        render json: {article: add_comments_count_to_response(@article)}, status: 200
      else
        render json: { error: 'Article not found!' }, status: 404
      end
  end


  def get_articles_author
    articles = Article.where(user_id: permit_params_id[:id])
    if articles.present?
      render json: {articles: add_comments_count_to_response(articles)}, status: 200
    else
      render json: { error: "Articles by author id:#{permit_params_id[:id]} not found!" }, status: 404
    end
  end


  def get_articles_category
      articles = Article.where(category: params.permit(:category)['category'])
      if articles.present?
        render json: {articles: add_comments_count_to_response(articles)}, status: 200
      else
        render json: { error: "Articles by category:#{params.permit(:category)['category']} not found!" }, status: 404
      end
  end



  def destroy
    if @article.user == @current_user
      if @article.destroy!
        render json: { succes: 'Article is deleted' }, status: 200
      end
    else
      render json: { error: 'Access denied. Removal is available only to the author' }, status: 403
    end
  end


  private


  def add_comments_count_to_response(articles)
    article_array = Array.new
    if articles.is_a? Article
      article_hash = articles.as_json
      article_hash['comments'] = articles.comments.count
      if articles.body.length > 500
        article_hash['body'] = article_hash['body'].truncate(500)
      end
      article_array << article_hash
    else
      articles.each do |article|
        article_hash = article.as_json
        article_hash['comments'] = article.comments.count
        if article.body.length > 500
          article_hash['body'] = article_hash['body'].truncate(500)
        end
        article_array << article_hash
      end
    end
    return article_array
  end

  def new_article_permit_params
    params.permit(:title, :body, :category, :publication_date)
  end

  def find_article
      @article = Article.where(id: permit_params_id[:id])
  end

  def permit_params_id
    params.permit(:id)
  end
end
