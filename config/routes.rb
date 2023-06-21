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

  # get "/users/search", 'devise/sessions#search'

  devise_scope :user do
    get 'users/sessions/search', :to => 'devise/sessions#search'
  end

  get "/review/my_reviews", 'review#my_reviews'
  get "/comment/my_comments", 'comment#my_comments'

  devise_scope :user do
    authenticated :user do
      root 'devise/sessions#index', as: :authenticated_root
      # get "/users/search", 'devise/sessions#search'
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