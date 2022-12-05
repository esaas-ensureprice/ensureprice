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
  get 'visits/:id', to: 'ensureprices#visits', as: 'visits'
  get 'price/:id', to: 'ensureprices#price', as: 'price'

  # Doctor Review route
  get 'reviews', to: 'doctor_reviews#reviews', as: 'reviews'

  # Answers route
  get 'ques_answers/:question_id', to: 'questions#ques_answers', as: 'ques_answers'

  resources :users
  resources :doctors
  resources :ensureprices
  resources :doctor_reviews
  resources :questions
  resources :answers
end
