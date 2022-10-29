Ensureprice::Application.routes.draw do
  resources :ensureprices
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/ensureprices')
end
