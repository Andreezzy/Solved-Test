require 'test_helper'

class OmniauthCallbacksControllerTest < ActionDispatch::IntegrationTest
  test "should get facebook" do
    get omniauth_callbacks_facebook_url
    assert_response :success
  end

end
