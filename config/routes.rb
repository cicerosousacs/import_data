Rails.application.routes.draw do 
  root "home#index"
  
  devise_for :admins
  get 'home/index'

  post 'import/type_tables'
  get 'import/index_type_tables'
  post 'import/main_tables'
  get 'import/index_main_tables'

  scope '/api' do
    resources :cnae
    resources :registration_situation
    resources :company_size
    resources :county

    get 'municipality_from_uf', to: 'municipality_district#municipality_from_uf'
    get 'district_from_municipality', to: 'municipality_district#district_from_municipality'

    get 'search_uniq', to: 'search#search_uniq'
    get 'search_all', to: 'search#search_all'
    get 'search_history/index'

    get 'export_to_xlsx', to: 'export#export_to_xlsx'
  end
end
