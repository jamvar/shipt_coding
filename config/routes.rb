Rails.application.routes.draw do
  get 'products/search' => 'product#search'
  get 'customers/:id/orders' => 'customer#show'
  post 'customers/:id/orders/new' => 'order#new'
end
