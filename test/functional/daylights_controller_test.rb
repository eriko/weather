require 'test_helper'

class DaylightsControllerTest < ActionController::TestCase
  setup do
    @daylight = daylights(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:daylights)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create daylight" do
    assert_difference('Daylight.count') do
      post :create, daylight: { start: @daylight.start, stop: @daylight.stop }
    end

    assert_redirected_to daylight_path(assigns(:daylight))
  end

  test "should show daylight" do
    get :show, id: @daylight
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @daylight
    assert_response :success
  end

  test "should update daylight" do
    put :update, id: @daylight, daylight: { start: @daylight.start, stop: @daylight.stop }
    assert_redirected_to daylight_path(assigns(:daylight))
  end

  test "should destroy daylight" do
    assert_difference('Daylight.count', -1) do
      delete :destroy, id: @daylight
    end

    assert_redirected_to daylights_path
  end
end
