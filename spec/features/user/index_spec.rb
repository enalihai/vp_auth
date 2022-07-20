# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  describe 'landing page' do
    it 'has the title of the application and exists as our landing page' do
      visit users_path

      expect(page).to have_content('Viewing Party Lite')
    end

    it 'has a link to login and users are taken to their dashboard' do
      oakley = User.create(name: 'Oakley', email: 'some_good_dog@gmail.com', password: 'password', password_confirmation: 'password')

      visit root_path

      click_link("Log In")
     
      expect(current_path).to eq(login_path)

      fill_in :email, with: 'some_good_dog@gmail.com'
      fill_in :password, with: "password"
      click_button "Log In"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("#{oakley.email} logged in!")
    end

    it "cannot log in with bad credentials" do
      user = User.create(name: 'Oakley', email: "some_good_dog@woof.com", password: "correct_password", password_confirmation: "correct_password")

      visit login_path

      fill_in :email, with: 'some_good_dog@woof.com'
      fill_in :password, with: "incorrect password"
      click_on "Log In"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Sorry, your credentials are bad.")

      fill_in :email, with: 'some_bad_dog@woof.com'
      fill_in :password, with: 'correct_password'
      click_on "Log In"

      expect(current_path).to eq(login_path)
      
      fill_in :email, with: ''
      fill_in :password, with: ''
      click_on "Log In"

      expect(current_path).to eq(login_path)
    end

    it 'has a list of existing users as links to the user dashboard' do
      oakley = User.create!(name: 'Oakley', email: 'good_dog@gmail.com', password: 'password', password_confirmation: 'password')
      kona = User.create!(name: 'Kona', email: 'goodd_dog@gmail.com', password: 'password', password_confirmation: 'password')
      hazel = User.create!(name: 'Hazel', email: 'a_dog@gmail.com', password: 'password', password_confirmation: 'password')

      visit users_path

      expect(page).to have_link("#{oakley.email}'s Dashboard")
      expect(page).to have_link("#{kona.email}'s Dashboard")

      click_link("#{hazel.email}'s Dashboard")

      expect(current_path).to eq("/users/#{hazel.id}")
    end
  end
end
