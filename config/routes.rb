Rails.application.routes.draw do
  # Admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # Sell
  get 'sell' => 'sell#index'

  scope "api" do
    # Cients
    resources :clients, :defaults => {:format => "json"}
    get 'clients/search/:data'  => 'clients#search', :defaults => {:format => "json"}

    # Providers
    resources :providers, :defaults => {:format => "json"}
    get 'providers/search/:data'  => 'providers#search', :defaults => {:format => "json"}

    # Tags
    resources :tags, :defaults => {:format => "json"}
    get 'tags/search/:data'  => 'tags#search', :defaults => {:format => "json"}
  end  

  # Root
  root 'sell#index'
end
