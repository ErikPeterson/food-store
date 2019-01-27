Rails.application.routes.draw do
  devise_for :users,
             path: '/',
             path_names: {
               sign_in: 'login',
               registration: 'signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }

  scope :api do
    scope :v1 do
      get '/stock_units' => 'stock_units#index'
      post '/stock_units' => 'stock_units#create'
      get '/stock_units/:id' => 'stock_units#show'
      post '/stock_units/:id' => 'stock_units#update'
      delete '/stock_units/:id' => 'stock_units#destroy'

      get '/stock_unit_types' => 'stock_unit_types#index'
      post '/stock_unit_types' => 'stock_unit_types#create'
      get '/stock_unit_types/:id' => 'stock_unit_types#get'
    end
  end

end
