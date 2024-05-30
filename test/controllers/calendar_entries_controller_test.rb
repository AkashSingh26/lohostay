require "test_helper"

class CalendarEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @calendar_entry = calendar_entries(:one)
  end

  test "should get index" do
    get calendar_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_calendar_entry_url
    assert_response :success
  end

  test "should create calendar_entry" do
    assert_difference("CalendarEntry.count") do
      post calendar_entries_url, params: { calendar_entry: { available: @calendar_entry.available, date: @calendar_entry.date, price: @calendar_entry.price, villa_id: @calendar_entry.villa_id } }
    end

    assert_redirected_to calendar_entry_url(CalendarEntry.last)
  end

  test "should show calendar_entry" do
    get calendar_entry_url(@calendar_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_calendar_entry_url(@calendar_entry)
    assert_response :success
  end

  test "should update calendar_entry" do
    patch calendar_entry_url(@calendar_entry), params: { calendar_entry: { available: @calendar_entry.available, date: @calendar_entry.date, price: @calendar_entry.price, villa_id: @calendar_entry.villa_id } }
    assert_redirected_to calendar_entry_url(@calendar_entry)
  end

  test "should destroy calendar_entry" do
    assert_difference("CalendarEntry.count", -1) do
      delete calendar_entry_url(@calendar_entry)
    end

    assert_redirected_to calendar_entries_url
  end
end
