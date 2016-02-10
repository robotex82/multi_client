Rails.application.routes.draw do
  mount MultiClient::Engine => '/multi_client'

  constraints MultiClient::NoSubdomain do
    resources :sessions, only: [:new, :create] do
      collection do
        delete :destroy
      end
    end
  end

  constraints MultiClient::Subdomain do
    resources :posts
  end

  constraints MultiClient::NoSubdomain do
    root to: 'sessions#new'
  end

  constraints MultiClient::Subdomain do
    root to: 'posts#index', as: 'root_with_subdomain'
  end
end
