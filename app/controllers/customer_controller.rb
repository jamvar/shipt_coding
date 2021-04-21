class CustomerController < ApplicationController
  def show
    customer = Customer.find_by_id(params[:id])

    if customer
      @customer = { first_name: customer.first_name, last_name: customer.last_name }
      @orders = Customer.orders_by_customer_query(customer.id)
      render json: {customer: @customer, orders: orders_by_customer(@orders)}
    else
      render json: {message: 'No Customer Found'}, status: 404
    end
  end

  # def new_order
  #   customer = Customer.find_by_id(params[:id])
  #
  #   if customer
  #     @customer = { first_name: customer.first_name, last_name: customer.last_name }
  #   else
  #     render json: {message: 'No Customer Found'}, status: 404
  #   end
  # end

  private

  def orders_by_customer(orders)
    formatted_orders = []

    orders.each do |order|
      formatted_orders << {
        id: order["order_id"],
        status: order["order_status"],
        date_ordered: order["order_created_at"]
      }
    end

    formatted_orders
  end
end
