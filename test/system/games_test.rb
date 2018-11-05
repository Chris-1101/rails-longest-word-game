require 'application_system_test_case'

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "span", count: 10
  end

  test "A random word tells us that the word is not in the grid" do
    visit new_url
  end

  test "A single letter tells us that the word is not valid" do
    visit new_url
  end

  test "A valid English word tells us that the word is valid" do
    visit new_url
  end
end
