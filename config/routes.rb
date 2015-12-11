Rails.application.routes.draw do
  root 'postcode#index'
  get '/search/:postcode' => "postcode#search"
end
