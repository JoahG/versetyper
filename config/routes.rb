Versetyper::Application.routes.draw do
  get "master/:id" => "verses#master", :as => "master"
  get "type/:id" => "verses#type", :as => "type"
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "sign_up" => "users#new", :as => "sign_up"
  resources :users, :sessions, :verses, :verse_completions
  root :to => "users#index"
end
