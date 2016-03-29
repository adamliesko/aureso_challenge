Rails.application.routes.draw do
  get '/models/:model_slug/model_types' => 'models#organization_models', defaults: { format: :json }
  post '/models/:model_slug/model_types_price/:model_type_slug' => 'model_types#price', defaults: { format: :json }
end
