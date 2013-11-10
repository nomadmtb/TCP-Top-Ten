require 'test_helper'

class OpenPortsControllerTest < ActionController::TestCase
  setup do
    @open_port = open_ports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:open_ports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create open_port" do
    assert_difference('OpenPort.count') do
      post :create, open_port: { port: @open_port.port, scan_id: @open_port.scan_id, service: @open_port.service }
    end

    assert_redirected_to open_port_path(assigns(:open_port))
  end

  test "should show open_port" do
    get :show, id: @open_port
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @open_port
    assert_response :success
  end

  test "should update open_port" do
    patch :update, id: @open_port, open_port: { port: @open_port.port, scan_id: @open_port.scan_id, service: @open_port.service }
    assert_redirected_to open_port_path(assigns(:open_port))
  end

  test "should destroy open_port" do
    assert_difference('OpenPort.count', -1) do
      delete :destroy, id: @open_port
    end

    assert_redirected_to open_ports_path
  end
end
