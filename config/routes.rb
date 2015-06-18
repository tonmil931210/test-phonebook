Rails.application.routes.draw do
  match '*path' => 'application#handle_options_request', :constraints => {:method => 'OPTIONS'}, via: :options
  # USERS
  resources :users, except: :new
  # SESSIONS
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  # AGENDAS
  resources :users do
    resources :agendas, except: [:new, :edit, :update]
  end
  # CONTACTS
  resources :users do
    resources :agendas do
      resources :contacts, except: :new
    end
  end
end

