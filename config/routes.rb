Rails.application.routes.draw do
  get 'products/search' => 'product#search'
  get 'customers/:id/orders' => 'customer#show'
end
