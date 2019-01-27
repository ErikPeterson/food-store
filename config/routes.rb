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
      post '/stock_units' => 'stock_units#create'
      get '/stock_units/:id' => 'stock_units#show'
      post '/stock_units/:id' => 'stock_units#update'
    end
  end

end
