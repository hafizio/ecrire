PothiboCom::Application.routes.draw do
  root 'posts#index'

  get '/:year/:month/:id', to: 'posts#show', constraints: { year: /\d+/, month: /\d+/ }, as: "post"
  get '/feed', to: 'posts#index', defaults: { format: :rss }
  get '/archives', to: 'posts#archive'

  resources :posts, only: [:index]

  resource :session, only: [:create, :destroy]

  resources :partials, only: [:show]

  namespace :admin do
    root 'posts#index'
    resources :posts
    resources :splits
    resources :partials
  end

end
