Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  Rails.application.routes.draw do
    resources :employees, only: [:index] do
      collection do
        get 'info'
      end
    end
  end
end
