Rails.application.routes.draw do
  # Admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # Sell
  get 'sell' => 'sell#index'

  # Inventory
  get 'inventory' => 'inventory#index'

  # Transactions & Bills
  get 'transactions_bills' => 'sell#index'

  # Costumers
  get 'costumers' => 'sell#index'

  # Manager
  get 'manager' => 'sell#index'

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

    # Products
    resources :products, :defaults => {:format => "json"}
    get 'products/search/:data'  => 'products#search', :defaults => {:format => "json"}
    get 'products_bestsellers'  => 'products#bestsellers', :defaults => {:format => "json"}

    # Product Providers
    resources :product_providers, :defaults => {:format => "json"}
    get 'product_providers/search/:product_id/:provider_id'  => 'product_providers#search', :defaults => {:format => "json"}
  end  

  # Root
  root 'sell#index'
end
