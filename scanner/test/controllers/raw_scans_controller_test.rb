require 'test_helper'

class RawScansControllerTest < ActionController::TestCase
  setup do
    @raw_scan = raw_scans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:raw_scans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create raw_scan" do
    assert_difference('RawScan.count') do
      post :create, raw_scan: { raw_xml: @raw_scan.raw_xml, scan_id: @raw_scan.scan_id }
    end

    assert_redirected_to raw_scan_path(assigns(:raw_scan))
  end

  test "should show raw_scan" do
    get :show, id: @raw_scan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @raw_scan
    assert_response :success
  end

  test "should update raw_scan" do
    patch :update, id: @raw_scan, raw_scan: { raw_xml: @raw_scan.raw_xml, scan_id: @raw_scan.scan_id }
    assert_redirected_to raw_scan_path(assigns(:raw_scan))
  end

  test "should destroy raw_scan" do
    assert_difference('RawScan.count', -1) do
      delete :destroy, id: @raw_scan
    end

    assert_redirected_to raw_scans_path
  end
end
