Ensureprice::Application.routes.draw do
  resources :ensureprices
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/ensureprices')
  get 'plans/:id', to: 'ensureprices#plans', as: 'plans'
  get 'doctors/:id', to: 'ensureprices#doctors', as: 'doctors'
  get 'visits/:id', to: 'ensureprices#visits', as: 'visits'
  get 'price/:id', to: 'ensureprices#price', as: 'price'
end
