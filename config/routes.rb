Rails.application.routes.draw do 
  # root "import#index"
  root "home#index"
  
  devise_for :admins
  post 'import/type_tables'
  get 'import/index_type_tables'
  post 'import/main_tables'
  get 'import/index_main_tables'

end
