require 'test_helper'

class BaseRostersControllerTest < ActionController::TestCase
  setup do
    @base_roster = create :base_roster
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:base_rosters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create base_roster" do
    assert_difference('BaseRoster.count') do
      post :create, base_roster: { commencement_date: @base_roster.commencement_date, depot: @base_roster.depot, duration: @base_roster.duration, link: @base_roster.link, name: @base_roster.name, version: @base_roster.version }
    end

    assert_redirected_to base_roster_path(assigns(:base_roster))
    assert assigns(:line), "didn't create first line."
  end

  test "should show base_roster" do
    get :show, id: @base_roster
    assert_response :success
    assert assigns(:base_roster)
  end

  test "should get edit" do
    get :edit, id: @base_roster
    assert_response :success
  end

  test "should update base_roster" do
    patch :update, id: @base_roster, base_roster: { commencement_date: @base_roster.commencement_date, depot: @base_roster.depot, duration: @base_roster.duration, link: @base_roster.link, name: @base_roster.name,  version: @base_roster.version }
    assert_redirected_to base_roster_path(assigns(:base_roster))
  end

  test "should destroy base_roster" do
    assert_difference('BaseRoster.count', -1) do
      delete :destroy, id: @base_roster
    end

    assert_redirected_to base_rosters_path
  end
end
