Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    resources :products
    resources :orders
    get '/cart', to: 'orders#show_guest_cart', as: 'guest_cart'
    get '/cart/:user_id', to: 'orders#show_cart', as: 'cart'
  end
end
