Rails.application.routes.draw do
  # get 'comment/index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  # devise_for :users
  
  # root 'review/index'

  # devise_scope :user do
  #   root => "devise/registrations#index"
  # end

  get "/review/my_reviews", 'review#my_reviews'
  get "/comment/my_comments", 'comment#my_comments'

  # devise_scope :user do
  #   post 'users/sessions/search', :to => 'devise/sessions#search'
  #   get 'users/sessions/search_results', :to => 'devise/sessions#search_results'
  # end

  devise_scope :user do
    # post 'users/sessions/search', :to => 'users/sessions#search'
    get 'users/sessions/search', :to => 'users/sessions#search'
    get 'users/sessions/search_results', :to => 'users/sessions#search_results'
  end

  devise_scope :user do
    authenticated :user do
      root 'devise/sessions#index', as: :authenticated_root
      # post 'users/sessions/search', :to => 'devise/sessions#search'
      # get 'users/sessions/search_results', :to => 'devise/sessions#search_results'
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  # resources :review, except: [:index]

  resources :review do
    resources :comment, only: [:create, :update, :destroy]
  end

 

  # resources :comment, only: [:create, :update, :destroy]



  # root "devise/registrations#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end


# add-reviewAndComment-models-tables