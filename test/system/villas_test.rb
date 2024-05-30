require "application_system_test_case"

class VillasTest < ApplicationSystemTestCase
  setup do
    @villa = villas(:one)
  end

  test "visiting the index" do
    visit villas_url
    assert_selector "h1", text: "Villas"
  end

  test "should create villa" do
    visit villas_url
    click_on "New villa"

    fill_in "Name", with: @villa.name
    click_on "Create Villa"

    assert_text "Villa was successfully created"
    click_on "Back"
  end

  test "should update Villa" do
    visit villa_url(@villa)
    click_on "Edit this villa", match: :first

    fill_in "Name", with: @villa.name
    click_on "Update Villa"

    assert_text "Villa was successfully updated"
    click_on "Back"
  end

  test "should destroy Villa" do
    visit villa_url(@villa)
    click_on "Destroy this villa", match: :first

    assert_text "Villa was successfully destroyed"
  end
end
