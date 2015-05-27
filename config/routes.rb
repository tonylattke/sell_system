Rails.application.routes.draw do
  # Admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # Sell
  get 'sell' => 'sell#index'

  # Cients
  get 'clients' => 'clients#index' 
  get 'clients/:id' => 'clients#show'


  # Root
  root 'sell#index'
end
