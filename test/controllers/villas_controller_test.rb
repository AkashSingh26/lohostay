require "test_helper"

class VillasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @villa = villas(:one)
  end

  test "should get index" do
    get villas_url
    assert_response :success
  end

  test "should get new" do
    get new_villa_url
    assert_response :success
  end

  test "should create villa" do
    assert_difference("Villa.count") do
      post villas_url, params: { villa: { name: @villa.name } }
    end

    assert_redirected_to villa_url(Villa.last)
  end

  test "should show villa" do
    get villa_url(@villa)
    assert_response :success
  end

  test "should get edit" do
    get edit_villa_url(@villa)
    assert_response :success
  end

  test "should update villa" do
    patch villa_url(@villa), params: { villa: { name: @villa.name } }
    assert_redirected_to villa_url(@villa)
  end

  test "should destroy villa" do
    assert_difference("Villa.count", -1) do
      delete villa_url(@villa)
    end

    assert_redirected_to villas_url
  end
end
