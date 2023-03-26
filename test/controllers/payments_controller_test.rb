require "test_helper"

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should get payment" do
    get payments_payment_url
    assert_response :success
  end
end
