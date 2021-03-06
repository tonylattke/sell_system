Rails.application.routes.draw do
  devise_for :users

  # Admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # Sell
  get 'sell' => 'sell#index'
  post 'sell/generate_sell' => 'sell#generate_sell', :defaults => {:format => "json"}
  get 'sell/search_articles_by_tag/:data' => 'sell#search_articles_by_tag', :defaults => {:format => "json"}
  post 'sell/retire_products' => 'sell#retire_products', :defaults => {:format => "json"}

  # Inventory
  get 'inventory' => 'inventory#index'

  get 'inventory/product_details/:product_id' => 'inventory#product_details', :defaults => {:format => "json"}
  get 'inventory/combo_details/:combo_id' => 'inventory#combo_details', :defaults => {:format => "json"}
  get 'inventory/tags_by_product/:product_id' => 'inventory#tags_by_product', :defaults => {:format => "json"}
  get 'inventory/providers_by_product/:product_id' => 'inventory#providers_by_product', :defaults => {:format => "json"}

  post 'inventory/save_tags' => 'inventory#save_product_tags', :defaults => {:format => "json"}
  post 'inventory/save_providers' => 'inventory#save_product_providers', :defaults => {:format => "json"}
  post 'inventory/add' => 'inventory#add', :defaults => {:format => "json"}

  delete 'inventory/delete_tags/:product' => 'inventory#delete_product_tags', :defaults => {:format => "json"}
  delete 'inventory/delete_providers/:product' => 'inventory#delete_product_providers', :defaults => {:format => "json"}

  get 'inventory/report' => "inventory#report"

  # Transactions & Bills
  get 'transactions_bills' => 'transactions_bills#index'
  get 'transactions_bills/consult_bill/:id' => 'transactions_bills#consult_bill', :defaults => {:format => "json"}

  delete 'transactions_bills/delete_bill/:id' => 'transactions_bills#delete_bill', :defaults => {:format => "json"}

  # Costumers
  get 'costumers' => 'costumers#index'
  get 'costumers/report' => 'costumers#report'
  #get 'costumers/barcode' => "costumers#barcode"

  # Manager
  get 'manager' => 'manager#index'
  get 'manager/transactions/today' => 'manager#transactions_today', :defaults => {:format => "json"}
  get 'manager/transactions/from/:fy-:fm-:fd/to/:ty-:tm-:td' => 'manager#transactions_from_to', :defaults => {:format => "json"}
  get 'manager/report/:fy-:fm-:fd/:ty-:tm-:td' => 'manager#report'

  scope "api" do
    # Clients
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

    # Combo Product
    resources :combo_products, :defaults => {:format => "json"}
    get 'combo_products/search_by_product/:product_id'  => 'combo_products#search_by_product', :defaults => {:format => "json"}
    get 'combo_products/search_by_combo/:combo_id'  => 'combo_products#search_by_combo', :defaults => {:format => "json"}
    get 'combo_products/search/:combo_id/:product_id'  => 'combo_products#search', :defaults => {:format => "json"}

    # Prices
    resources :prices, :defaults => {:format => "json"}
    get 'prices/search_by_product/:product_id'  => 'prices#search_by_product', :defaults => {:format => "json"}
    get 'prices/search_by_combo/:combo_id'  => 'prices#search_by_combo', :defaults => {:format => "json"}

    # Bills
    get 'bills/today'  => 'bills#today', :defaults => {:format => "json"}
    get 'bills/from/:fy-:fm-:fd/to/:ty-:tm-:td' => 'bills#from_to', :defaults => {:format => "json"}
    resources :bills, :defaults => {:format => "json"}

    # Bill Articles
    resources :bill_articles, :defaults => {:format => "json"}

    # Sale Transactions
    resources :sale_transactions, :defaults => {:format => "json"}

    # Cash Transactions
    get 'cash_transactions/today'  => 'cash_transactions#today', :defaults => {:format => "json"}
    get 'cash_transactions/from/:fy-:fm-:fd/to/:ty-:tm-:td' => 'cash_transactions#from_to', :defaults => {:format => "json"}
    resources :cash_transactions, :defaults => {:format => "json"}
  end  

  # Root
  root 'sell#index'
end
