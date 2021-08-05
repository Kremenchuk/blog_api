Rails.application.routes.draw do


  # users
  post 'login', to: 'authentication#authenticate'
  post 'signup', to: 'authentication#signup'

  namespace :api do
  #articles
    post 'new_article', to: 'articles#create'
    get 'get_articles', to: 'articles#index'
    get 'get_article', to: 'articles#show'
    get 'get_articles_author', to: 'articles#get_articles_author'
    get 'get_articles_category', to: 'articles#get_articles_category'
    delete 'delete_article', to: 'articles#destroy'


    #comments
    post 'new_comment', to: 'comments#create'
    get 'get_comments', to: 'comments#index'
    delete 'delete_comment', to: 'comments#destroy'

  end
end
