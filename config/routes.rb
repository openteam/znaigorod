Znaigorod::Application.routes.draw do

  root :to => 'index#index'

  resources :institutions do
    resources :kinds
  end

  resources :institution_classes do
    resources :institution_kinds, :except => [:index] do
      resources :attributes
    end
  end

end