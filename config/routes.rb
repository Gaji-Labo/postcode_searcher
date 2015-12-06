Rails.application.routes.draw do
  get '/search/:postcode' => "postcode#search"
end
