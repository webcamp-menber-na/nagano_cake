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
  
  namespace :admin do
    get '' => 'homes#top'
    resources :items,only: [:new, :index, :show, :edit]
    resources :customers,only: [:index, :show, :edit]
    resources :orders,only: [:show]
  end
end
