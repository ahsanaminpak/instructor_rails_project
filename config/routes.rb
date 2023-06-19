Rails.application.routes.draw do
  get 'comment/index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  # devise_for :users
  
  # root 'review/index'

  # devise_scope :user do
  #   root => "devise/registrations#index"
  # end

  devise_scope :user do
    authenticated :user do
      root 'devise/sessions#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  # root "devise/registrations#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end


# add-reviewAndComment-models-tables