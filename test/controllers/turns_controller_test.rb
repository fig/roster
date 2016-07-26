require 'test_helper'

class TurnsControllerTest < ActionController::TestCase
  test "routes request correctly" do
    get 'index'
    assert_response :success
  end
end
