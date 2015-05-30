Rails.application.routes.draw do
  # Admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # Sell
  get 'sell' => 'sell#index'

  # Cients
  scope "api" do
    resources :clients, :defaults => {:format => "json"}
    get 'clients/search/:data'  => 'clients#search', :defaults => {:format => "json"}
  end  

  # Root
  root 'sell#index'
end
