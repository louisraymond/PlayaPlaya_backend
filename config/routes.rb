Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :songs
      post '/login', to: 'users#login'
      get '/song_list', to: 'users#song_list'
      get '/current_user', to: 'users#get_current_user'
    end
  end

end
