Znaigorod::Application.routes.draw do

  root :to => 'index#index'

  resources :institutions do
    resources :kinds, :except => [:index]
  end

  resources :institution_classes do
    resources :institution_kinds, :except => [:index] do
      resources :parameters, :except => [:index]
    end
  end

end