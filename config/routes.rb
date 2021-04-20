Rails.application.routes.draw do
  get 'product/sold_by_date_range'
  get 'customer/:customer_id' => 'customer#show'
end
