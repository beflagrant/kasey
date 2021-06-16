Kasey::Engine.routes.draw do
  resources :kases, only: [:index, :show, :destroy]  do
    collection do
      get 'closed'
    end
    
    resources :messages, only: [:create, :edit, :update]
  end

end
