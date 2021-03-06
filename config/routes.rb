Enki::Application.routes.draw do
  namespace 'admin' do
    get 'login' => 'base#login'
    resources :posts, :pages do
      post 'preview', :on => :collection
    end
    resources :comments
    resources :undo_items do
      post 'undo', :on => :member
    end

    match 'health(/:action)' => 'health', :action => 'index', :as => :health

    root :to => 'dashboard#show'
  end

  scope :path => '/auth' do
    #get ':service/callback' => 'sessions#create'
    get 'failure' => 'sessions#failure'
    get 'logout' => 'sessions#logout', :as => :logout
  end
  match '/auth/:service/callback' => 'sessions#create'

  resources :archives, :only => [:index]
  resources :pages, :only => [:show]

  constraints :year => /\d{4}/, :month => /\d{2}/, :day => /\d{2}/ do
    get ':year/:month/:day/:slug/comments'  => 'comments#index'
    post ':year/:month/:day/:slug/comments' => 'comments#create'
    get ':year/:month/:day/:slug/comments/new' => 'comments#new'
    get ':year/:month/:day/:slug/comments/form' => 'comments#form', :as => :comment_form
    get ':year/:month/:day/:slug' => 'posts#show'
  end

  scope :to => 'posts#index' do
    get 'posts.:format', :as => :formatted_posts
    get '(:tag)', :as => :posts
  end

  root :to => 'posts#index'
end
