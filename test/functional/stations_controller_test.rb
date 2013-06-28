require 'test_helper'

class StationsControllerTest < ActionController::TestCase
  setup do
    @station = stations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create station" do
    assert_difference('Station.count') do
      post :create, station: { description: @station.description, height_high: @station.height_high, height_low: @station.height_low, longname: @station.longname, name: @station.name, parent_id: @station.parent_id, time_high: @station.time_high, time_low: @station.time_low, url: @station.url }
    end

    assert_redirected_to station_path(assigns(:station))
  end

  test "should show station" do
    get :show, id: @station
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @station
    assert_response :success
  end

  test "should update station" do
    put :update, id: @station, station: { description: @station.description, height_high: @station.height_high, height_low: @station.height_low, longname: @station.longname, name: @station.name, parent_id: @station.parent_id, time_high: @station.time_high, time_low: @station.time_low, url: @station.url }
    assert_redirected_to station_path(assigns(:station))
  end

  test "should destroy station" do
    assert_difference('Station.count', -1) do
      delete :destroy, id: @station
    end

    assert_redirected_to stations_path
  end
end
