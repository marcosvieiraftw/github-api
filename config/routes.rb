Rails.application.routes.draw do
  resources :actors do
    collection do
      put '/', to: 'actors#update'
      get '/', to: 'actors#list_by_amount_of_events'
      get '/streak', to: 'actors#list_by_streak'
    end
  end
  resources :events do
    collection do
      get '/actors/:actor_id',
        to: 'events#list_by_actor',
        constraints: {
          actor_id: /\d+/
        }
    end
  end
  delete '/erase', to: 'erases#destroy'
end
