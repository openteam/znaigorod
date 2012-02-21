Znaigorod::Application.routes.draw do

  resources :institutions do
    member {
      get 'add_kind'
      put 'delete_kind'
    }
    resources :kinds
  end

  resources :institution_classes do
    resources :institution_kinds do
      resources :attributes
    end
  end

end