require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  setup do
    @profile = create :profile
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profile" do
    assert_difference('Profile.count') do
      post :create, profile: { name_first: @profile.name_first, name_last: @profile.name_last, roster_epoch: @profile.roster_epoch, user_id: @profile.user_id }
    end

    assert_redirected_to profile_path(assigns(:profile))
  end

  test "should show profile" do
    skip 'need to move calendar out of profiles_controller.rb'
    get :show, id: @profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile
    assert_response :success
  end

  test "should update profile" do
    patch :update, id: @profile, profile: { name_first: @profile.name_first, name_last: @profile.name_last, roster_epoch: @profile.roster_epoch, user_id: @profile.user_id }
    assert_redirected_to profile_path(assigns(:profile))
  end

  test "should destroy profile" do
    assert_difference('Profile.count', -1) do
      delete :destroy, id: @profile
    end

    assert_redirected_to profiles_path
  end
end
