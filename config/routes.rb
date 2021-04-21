Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'products/sales_by_date_range' => 'products#sales_by_date_range'
      get 'customers/:id/orders' => 'customers#show_orders'
      post 'customers/:id/orders/new' => 'orders#new'
    end
  end

  match '*path', to: "errors#handle_root_not_found", via: [:get, :post]
end
