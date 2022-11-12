Ensureprice::Application.routes.draw do
  # Main Application routes
  # map '/' to be a redirect to '/ensureprices' site
  # root :to => redirect('/ensureprices')

  # Home page
  root 'static_pages#home'
  get 'help', to: 'static_pages#help'
  get 'about', to: 'static_pages#about'

  # New User signup and login routes
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Main Application routes
  get 'plans/:id', to: 'ensureprices#plans', as: 'plans'
  get 'doctors/:id', to: 'ensureprices#doctors', as: 'doctors'
  get 'visits/:id', to: 'ensureprices#visits', as: 'visits'
  get 'price/:id', to: 'ensureprices#price', as: 'price'

  get 'reviews', to: 'doctor_reviews#reviews', as: 'reviews'
  get 'edit_review/:id', to: 'users#edit_review', as: 'edit_user_review'

  resources :users
  resources :ensureprices
  resources :doctor_reviews
end
