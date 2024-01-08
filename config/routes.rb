Rails.application.routes.draw do
  root 'public/homes#top'
    #管理者用
    devise_for :admin, skip: [:registrations, :passwords], controllers: {
      sessions: "admin/sessions"
    }
  
    #顧客用
    devise_for :customers, skip: [:passwords], controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
    }
  
  namespace :public do
    get '/about' => 'homes#about'
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :items,only: [:index, :show, :create]
    resources :cart_items,only: [:index, :update, :create, :destroy]
    resources :orders,only: [:new, :index, :create, :show]
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/complete' => 'orders#complete'
    get "/customers/confirm" => "customers#confirm"
    patch "/customers/withdraw" => "customers#withdraw"
    resources :customers, path: 'my_page', only: [:show, :edit, :update]
    get '/customers/confirm' => 'customers#confirm'
  end
    
    
  namespace :admin do
    get '' => 'homes#top'
    resources :items,only: [:new, :create, :index, :show, :edit, :update]
    resources :customers,only: [:index, :show, :edit, :update]
    resources :orders,only: [:show]
  end
end
