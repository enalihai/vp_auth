require 'rails_helper'

RSpec.describe "The User Movies Index page" do
  describe 'top rated movies' do
    it 'has a list of top rated movies', :vcr do
      oakley = User.create!(name: "Oakley", email: "good_dog@gmail.com")

      visit "/users/#{oakley.id}/discover"

      click_button "Find Top Rated Movies"

      # expect(current_path).to eq("/users/#{oakley.id}/movies?q=top%20rated")
      expect(current_path).to eq("/users/#{oakley.id}/movies")
      expect(page).to have_content("Viewing Party Lite")
      expect(page).to have_content("Top Rated Movies")
      expect(page).to have_content("Vote Average:")
    end
  end

  describe 'movies search feature' do
    it 'can search for movies based on search criteria', :vcr do
      oakley = User.create!(name: "Oakley", email: "good_dog@gmail.com")

      visit "/users/#{oakley.id}/discover"

      fill_in :q, with: "top gun"
      click_button "Find Movies"

      # expect(current_path).to eq("/users/#{oakley.id}/movies?q=keyword")
      expect(current_path).to eq("/users/#{oakley.id}/movies")
      expect(page).to have_content("Viewing Party Lite")
      expect(page).to have_content("Movie results for:")
      expect(page).to have_content("Vote Average:")
      expect(page).to_not have_content("Fight Club")
      expect(page).to have_content("Top Gun")
    end

    xit 'will not run if search field is blank', :vcr do
      # FIXME: this sad path test will error because even though the page
      # is setup to not allow a user to enter an empty value,
      # for some reason the test does allow an empty value to be
      # entered so it does not fail as expected
      oakley = User.create!(name: "Oakley", email: "good_dog@gmail.com")

      visit "/users/#{oakley.id}/discover"

      # fill_in :q, with: ""
      click_button "Find Movies"

      # expect(current_path).to eq("/users/#{oakley.id}/discover")
      expect(page).to have_content("Please fill out this field")
    end
  end
end
