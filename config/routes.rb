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
    resources :items,only: [:index, :show]
    resources :cart_items,only: [:index, :update, :create, :destroy]
    resources :orders,only: [:new, :index, :create, :show]
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/complete' => 'orders#complete'
    resources :customers,only: [:show, :edit, :update], path: '/my_page', param: :customer_id do
    end
    get '/customers/confirm' => 'customers#confirm'
    patch '/customers/withdrawal' => 'customers#withdrawal'
  end
    
    
  namespace :admin do
    get '' => 'homes#top'
    resources :items,only: [:new, :index, :show, :edit]
    resources :customers,only: [:index, :show, :edit]
    resources :orders,only: [:show]
  end
end
