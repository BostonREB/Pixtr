Pixtr::Application.routes.draw do
get "galleries/random_gallery" => "random_galleries#show"

  root "homes#show"

get "/search" => "searches#index"
  resource :search, only: [:index]

  resource :dashboard, only: [:show]

  resources :tags, only: [:show]
  
  resources :galleries do
    member do  #
      post "like" => "gallery_likes#create"   #should have just called it "likes"
      delete "unlike" => "gallery_likes#destroy"
    end
    resources :images, only: [:new, :create]
  end

  resources :groups, only: [:index, :new, :create, :show] do
    member do
      post "join" => "group_memberships#create"
      delete "leave" => "group_memberships#destroy"
    end
    member do  #
      post "like" => "group_likes#create"   #should have just called it "likes"
      delete "unlike" => "group_likes#destroy"
    end
  end

  resources :images, except: [:index, :new, :create] do
    member do  #
      post "like" => "image_likes#create"   #should have just called it "likes"
      delete "unlike" => "image_likes#destroy"
    end
    resources :comments, only: [:create]
  end

  resources :comments, only: [:destroy]

  resources :users, only: [:show] do
    member do # /users/:id.  A member of the user.
      post "follow" => "following_relationships#create"
      delete "unfollow" => "following_relationships#destroy"
    end
  end


end
