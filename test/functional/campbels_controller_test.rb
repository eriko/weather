require 'test_helper'

class CampbelsControllerTest < ActionController::TestCase
  setup do
    @campbel = campbels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:campbels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create campbel" do
    assert_difference('Campbel.count') do
      post :create, campbel: { air_temp_c_avg: @campbel.air_temp_c_avg, air_temp_c_max: @campbel.air_temp_c_max, air_temp_c_min: @campbel.air_temp_c_min, dew_point_c_max: @campbel.dew_point_c_max, dew_point_c_min: @campbel.dew_point_c_min, etrs_mm_total: @campbel.etrs_mm_total, heat_index_c_max: @campbel.heat_index_c_max, heat_index_c_min: @campbel.heat_index_c_min, rain_mm_total: @campbel.rain_mm_total, record_num: @campbel.record_num, timestamp: @campbel.timestamp, wind_chill_c_max: @campbel.wind_chill_c_max, wind_chill_c_min: @campbel.wind_chill_c_min, wind_speed_avg: @campbel.wind_speed_avg, wind_speed_ms_max: @campbel.wind_speed_ms_max }
    end

    assert_redirected_to campbel_path(assigns(:campbel))
  end

  test "should show campbel" do
    get :show, id: @campbel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @campbel
    assert_response :success
  end

  test "should update campbel" do
    put :update, id: @campbel, campbel: { air_temp_c_avg: @campbel.air_temp_c_avg, air_temp_c_max: @campbel.air_temp_c_max, air_temp_c_min: @campbel.air_temp_c_min, dew_point_c_max: @campbel.dew_point_c_max, dew_point_c_min: @campbel.dew_point_c_min, etrs_mm_total: @campbel.etrs_mm_total, heat_index_c_max: @campbel.heat_index_c_max, heat_index_c_min: @campbel.heat_index_c_min, rain_mm_total: @campbel.rain_mm_total, record_num: @campbel.record_num, timestamp: @campbel.timestamp, wind_chill_c_max: @campbel.wind_chill_c_max, wind_chill_c_min: @campbel.wind_chill_c_min, wind_speed_avg: @campbel.wind_speed_avg, wind_speed_ms_max: @campbel.wind_speed_ms_max }
    assert_redirected_to campbel_path(assigns(:campbel))
  end

  test "should destroy campbel" do
    assert_difference('Campbel.count', -1) do
      delete :destroy, id: @campbel
    end

    assert_redirected_to campbels_path
  end
end
