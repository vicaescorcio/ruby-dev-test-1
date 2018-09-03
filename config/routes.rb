Rails.application.routes.draw do
  root 'home#index'

  resources :folders
  resources :assets, path: "asset", except: [:index]
  get "assets/get/:id" => "assets#get", :as => "download"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "browse/:folder_id" => "home#browse", :as => "browse"
  get "browse/:folder_id/new_folder" => "folders#new", :as => "new_sub_folder"
  get "browse/:folder_id/new_file" => "assets#new", :as => "new_sub_file"
  get "browse/:id/rename" => "folders#edit", :as => "rename_folder"
end
