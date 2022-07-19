# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registration Page', type: :feature do
  describe 'New User View' do
    it 'has a form that can create a new user' do
      visit root_path

      click_on "Register as a User"

      expect(current_path).to eq(new_user_path)

      email = "HazelTheDog@gmail.com"
      name = "Hazel the Dog"

      fill_in(:user_name, with: name)
      fill_in(:user_email, with: email)
      fill_in(:user_password, with: 'password')
      fill_in(:user_password_confirmation, with: 'password')

      click_on 'Register User'
   
      expect(page).to have_content("Welcome, #{name}")
    end

    xit 'will return an error if name is missing' do
      visit root_path

      click_link "Register as a User"

      expect(page).to_not have_content('A required field was missing or email is already in use')

      fill_in(:name, with: "")
      fill_in(:email, with: 'not-frankenstein@gmail.com')
      fill_in(:password, with: 'password')
      fill_in(:password_confirmation, with: 'password')
      click_button('Create New User')

      expect(current_path).to eq('/register')
      expect(page).to have_content('A required field was missing or email is already in use')
    end

    xit 'will return an error if email is missing' do
      visit root_path

      click_link "Register as a User"

      expect(page).to_not have_content('A required field was missing or email is already in use')

      fill_in(:name, with: "Frankenstein's Monster")
      fill_in(:email, with: '')
      fill_in(:password, with: 'password')
      fill_in(:password_confirmation, with: 'password')
      click_button('Create New User')

      expect(current_path).to eq('/register')
      expect(page).to have_content('A required field was missing or email is already in use')
    end

    xit 'will return an error if email is not unique' do
      User.create(name: 'Adam Frankenstein', email: 'not-frankenstein@gmail.com', password: 'password', password_confirmation: 'password')
      visit root_path

      click_link "Register as a User"

      expect(page).to_not have_content('A required field was missing or email is already in use')

      fill_in(:name, with: "Frankenstein's Monster")
      fill_in(:email, with: 'not-frankenstein@gmail.com')
      fill_in(:password, with: 'password')
      fill_in(:password_confirmation, with: 'password')
      click_button('Create New User')

      expect(current_path).to eq('/register')
      expect(page).to have_content('A required field was missing or email is already in use')
    end
  end
end
