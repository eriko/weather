require 'test_helper'

class SunsControllerTest < ActionController::TestCase
  setup do
    @sun = suns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:suns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sun" do
    assert_difference('Sun.count') do
      post :create, sun: { rise: @sun.rise, set: @sun.set }
    end

    assert_redirected_to sun_path(assigns(:sun))
  end

  test "should show sun" do
    get :show, id: @sun
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sun
    assert_response :success
  end

  test "should update sun" do
    put :update, id: @sun, sun: { rise: @sun.rise, set: @sun.set }
    assert_redirected_to sun_path(assigns(:sun))
  end

  test "should destroy sun" do
    assert_difference('Sun.count', -1) do
      delete :destroy, id: @sun
    end

    assert_redirected_to suns_path
  end
end
