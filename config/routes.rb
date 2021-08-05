Rails.application.routes.draw do


  # users
  post 'login', to: 'authentication#authenticate'
  post 'signup', to: 'authentication#signup'

  #articles
  post 'new_article', to: 'articles#new_article'
  get 'get_articles', to: 'articles#get_articles'
  get 'get_article', to: 'articles#get_article'
  get 'get_articles_author', to: 'articles#get_articles_author'
  get 'get_articles_category', to: 'articles#get_articles_category'
  delete 'delete_article', to: 'articles#delete_article'


  #comments
  post 'new_comment', to: 'comments#new_comment'
  get 'get_comments', to: 'comments#get_comments'
  delete 'delete_comment', to: 'comments#delete_comment'
end
