require 'rails_helper'

describe Api::ArticlesController, type: :request  do #AuthenticationController

  let(:signup_url)             {'/api/signup'}
  let(:login_url)              {'/api/login'}
  let(:new_article)            {'/api/new_article'}
  let(:get_articles)           {'/api/get_articles'}
  let(:get_article)            {'/api/get_article'}
  let(:get_articles_author)    {'/api/get_articles_author'}
  let(:get_articles_category)  {'/api/get_articles_category'}

  User.create(email: '312@123.com', password: '1234567')
  user = User.find_by(email: '312@123.com')
  article = FactoryBot.build(:article)


  context 'Create new article' do
    before do

      post signup_url, params: {
          user: {
              email: user.email,
              password: '1234567'
          }
      }

      post login_url, params: {
          user: {
              email: user.email,
              password: '1234567'
          }
      }

      post new_article, headers:{Authorization: response.headers['Authorization']} ,params: {
          title: article.title,
          body: article.body,
          category: article.category,
          publication_date: article.publication_date

          }


    end
    article.user = user
    article.save!

    it 'returns 201' do
      expect(response.status).to eq(200)
    end

  end


  context 'Take all articles' do
    before do
      post login_url, params: {
          user: {
              email: user.email,
              password: '1234567'
          }
      }
      get get_articles, headers:{Authorization: response.headers['Authorization']} ,params: {}
    end
    it 'return all articles' do
      expect(response.status).to eq(200)
    end
  end



  context 'Take one article' do
    before do
      post login_url, params: {
          user: {
              email: user.email,
              password: '1234567'
          }
      }

      get get_article, headers:{Authorization: response.headers['Authorization']},
          params: {
              id: Article.first.id
          }
    end
    it 'return article' do
      expect(response.status).to eq(200)
    end
  end

  context 'Take one article' do
    before do
      post login_url, params: {
          user: {
              email: user.email,
              password: '1234567'
          }
      }

      get get_article, headers:{Authorization: response.headers['Authorization']},
          params: {
              id: Article.first.id
          }
    end
    it 'return article' do
      expect(response.status).to eq(200)
    end
  end

  context 'get articles by a specific author' do
    before do
      post login_url, params: {
          user: {
              email: user.email,
              password: '1234567'
          }
      }

      get get_articles_author, headers:{Authorization: response.headers['Authorization']},
          params: {
              id: User.first.id
          }
    end
    it 'return articles' do
      expect(response.status).to eq(200)
    end
  end

  context 'get articles by a specific category' do
    before do
      post login_url, params: {
          user: {
              email: user.email,
              password: '1234567'
          }
      }

      get get_articles_category, headers:{Authorization: response.headers['Authorization']},
          params: {
              category: Article.first.category
          }
    end
    it 'return articles' do
      expect(response.status).to eq(200)
    end
  end





end