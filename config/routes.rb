Ensureprice::Application.routes.draw do
  resources :ensureprices
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/ensureprices')
  get 'insurance_plans/:id', to: 'ensureprices#plans', as: 'plans'
  get 'doctors/:id', to: 'ensureprices#doctors', as: 'doctors'
end
