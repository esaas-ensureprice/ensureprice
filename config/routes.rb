Rottenpotatoes::Application.routes.draw do
  resources :ensureprice
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/ensureprice')
end
