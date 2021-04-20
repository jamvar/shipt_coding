class CustomerController < ApplicationController
  def show
    customer = Customer.find_by_id(params[:customer_id])

    if customer
      @customer = { first_name: customer.first_name, last_name: customer.last_name }
      @orders = Customer.orders_by_customer(customer.id)
      render json: {customer: @customer, orders: @orders}
    else
      render json: {message: 'No Customer Found'}, status: 404
    end
  end
end
