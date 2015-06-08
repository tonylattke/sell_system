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
    get 'product_providers/search_by_product/:product_id'  => 'product_providers#search_by_product', :defaults => {:format => "json"}
    get 'product_providers/search_by_provider/:provider_id'  => 'product_providers#search_by_provider', :defaults => {:format => "json"}
    get 'product_providers/search/:product_id/:provider_id'  => 'product_providers#search', :defaults => {:format => "json"}

    # Product Tags
    resources :product_tags, :defaults => {:format => "json"}
    get 'product_tags/search_by_product/:product_id'  => 'product_tags#search_by_product', :defaults => {:format => "json"}
    get 'product_tags/search_by_tag/:tag_id'  => 'product_tags#search_by_tag', :defaults => {:format => "json"}
    get 'product_tags/search/:product_id/:tag_id'  => 'product_tags#search', :defaults => {:format => "json"}

    # Combos
    resources :combos, :defaults => {:format => "json"}
    get 'combos/search/:data'  => 'combos#search', :defaults => {:format => "json"}
    get 'combos_bestsellers'  => 'combos#bestsellers', :defaults => {:format => "json"}
  end  

  # Root
  root 'sell#index'
end
