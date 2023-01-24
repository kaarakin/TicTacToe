Rails.application.routes.draw do
  devise_for :users
  # /games/4/moves
  resources :games do
    resources :moves, only: [:create]
  end

  root to: 'games#welcome'
  get '/leaderboard', to: 'games#leaderboard'
  
end
