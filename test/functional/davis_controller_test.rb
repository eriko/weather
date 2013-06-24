require 'test_helper'

class DavisControllerTest < ActionController::TestCase
  setup do
    @davi = davis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:davis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create davi" do
    assert_difference('Davi.count') do
      post :create, davi: { bp: @davi.bp, dp: @davi.dp, hot: @davi.hot, hws: @davi.hws, ih: @davi.ih, it: @davi.it, lot: @davi.lot, oh: @davi.oh, ot: @davi.ot, r: @davi.r, recorded_datetime: @davi.recorded_datetime, wc: @davi.wc, wd: @davi.wd, ws: @davi.ws }
    end

    assert_redirected_to davi_path(assigns(:davi))
  end

  test "should show davi" do
    get :show, id: @davi
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @davi
    assert_response :success
  end

  test "should update davi" do
    put :update, id: @davi, davi: { bp: @davi.bp, dp: @davi.dp, hot: @davi.hot, hws: @davi.hws, ih: @davi.ih, it: @davi.it, lot: @davi.lot, oh: @davi.oh, ot: @davi.ot, r: @davi.r, recorded_datetime: @davi.recorded_datetime, wc: @davi.wc, wd: @davi.wd, ws: @davi.ws }
    assert_redirected_to davi_path(assigns(:davi))
  end

  test "should destroy davi" do
    assert_difference('Davi.count', -1) do
      delete :destroy, id: @davi
    end

    assert_redirected_to davis_path
  end
end
