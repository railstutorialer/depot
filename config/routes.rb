Rails.application.routes.draw do
  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users

  get 'order_management', to: 'order_management#index', as: 'order_management'
  post 'order_management/ship/:id', to: 'order_management#ship', as: 'ship_order'
  get 'order_management/show_change_ship_date/:id', to: 'order_management#show_change_ship_date', as: 'show_change_ship_date'
  patch 'order_management/change_ship_date/:id', to: 'order_management#change_ship_date', as: 'change_ship_date'

  resources :products do
    get :who_bought, on: :member
  end

  post 'change_locale', to: 'i18n#change_locale', as: 'change_locale'

  scope '(:locale)' do
    resources :orders

    resources :carts
    resources :line_items do
      member do
        post 'decrement'
      end
    end
    post 'add_product/:product_id', to: 'line_items#add_product', as: 'add_product_line_item'

    root 'store#index', as: 'store_index'
  end
end
