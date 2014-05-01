TweetRegionAnalyzer::Application.routes.draw do
  root to: "regions#index"
  resources :regions, :only => [:create, :index, :show]
end
