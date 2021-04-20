require 'test_helper'

class ProductControllerTest < ActionDispatch::IntegrationTest
  test "should get sold_by_date_range" do
    get product_sold_by_date_range_url
    assert_response :success
  end

end
