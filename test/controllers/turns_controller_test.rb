require 'test_helper'

class TurnsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:turns)
  end
end
