class ErrorsController < ApplicationController
  def handle_root_not_found
    render json: { message: "request url not found" }, status: 404
  end
end
