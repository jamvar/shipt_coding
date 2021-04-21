class OrderController < ApplicationController
  def new
    customer = Customer.find_by_id(params[:id])

    if customer
      @customer = { first_name: customer.first_name, last_name: customer.last_name }
      @order = new_order(customer.id, params[:products])
      render json: {message: 'Order Created'}, status: 201
    else
      render json: {message: 'No Customer Found'}, status: 404
    end
  end

  private

  def new_order(customer_id, products)
    created_order_id = Order.new_order_query(customer_id).first['id']
    order_products = products.each do |p|
                       Order.add_products_to_order_query(created_order_id, p["id"], p["quantity"])
                     end
  end
end
