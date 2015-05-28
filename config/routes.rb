Rails.application.routes.draw do
  # Admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # Sell
  get 'sell' => 'sell#index'

  # Cients
  get 'clients/search/:data' => 'clients#search'
  get 'clients/:id' => 'clients#show'
  get 'clients' => 'clients#index' 
  
  
  

  # Root
  root 'sell#index'
end
