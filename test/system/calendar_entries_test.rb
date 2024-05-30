require "application_system_test_case"

class CalendarEntriesTest < ApplicationSystemTestCase
  setup do
    @calendar_entry = calendar_entries(:one)
  end

  test "visiting the index" do
    visit calendar_entries_url
    assert_selector "h1", text: "Calendar entries"
  end

  test "should create calendar entry" do
    visit calendar_entries_url
    click_on "New calendar entry"

    check "Available" if @calendar_entry.available
    fill_in "Date", with: @calendar_entry.date
    fill_in "Price", with: @calendar_entry.price
    fill_in "Villa", with: @calendar_entry.villa_id
    click_on "Create Calendar entry"

    assert_text "Calendar entry was successfully created"
    click_on "Back"
  end

  test "should update Calendar entry" do
    visit calendar_entry_url(@calendar_entry)
    click_on "Edit this calendar entry", match: :first

    check "Available" if @calendar_entry.available
    fill_in "Date", with: @calendar_entry.date
    fill_in "Price", with: @calendar_entry.price
    fill_in "Villa", with: @calendar_entry.villa_id
    click_on "Update Calendar entry"

    assert_text "Calendar entry was successfully updated"
    click_on "Back"
  end

  test "should destroy Calendar entry" do
    visit calendar_entry_url(@calendar_entry)
    click_on "Destroy this calendar entry", match: :first

    assert_text "Calendar entry was successfully destroyed"
  end
end
