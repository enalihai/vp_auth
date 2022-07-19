# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registration Page', type: :feature do
  describe 'New User View' do
    it 'has a form that can create a new user' do
      visit root_path

      click_on "Register as a User"

      expect(current_path).to eq('/register')

      email = "HazelTheDog@gmail.com"
      name = "Hazel the Dog"

      fill_in(:user_name, with: name)
      fill_in(:user_email, with: email)
      fill_in(:user_password, with: 'password')
      fill_in(:user_password_confirmation, with: 'password')

      click_on 'Register User'
   
      expect(page).to have_content("#{name}")
    end

    it 'will return an error if name is missing' do
      visit root_path

      click_link "Register as a User"

      expect(page).to_not have_content("Sorry, your credentials are bad.")

      fill_in(:user_name, with: "")
      fill_in(:user_email, with: 'not-frankenstein@gmail.com')
      fill_in(:user_password, with: 'password')
      fill_in(:user_password_confirmation, with: 'password')
      click_on('Register User')

      expect(current_path).to eq('/register')
      expect(page).to have_content("Sorry, your credentials are bad.")
    end

    it 'will return an error if email is missing' do
      visit root_path

      click_link "Register as a User"

      expect(page).to_not have_content("Sorry, your credentials are bad.")

      fill_in(:user_name, with: "Frankenstein's Monster")
      fill_in(:user_email, with: '')
      fill_in(:user_password, with: 'password')
      fill_in(:user_password_confirmation, with: 'password')
      click_on('Register User')

      expect(current_path).to eq('/register')
      expect(page).to have_content("Sorry, your credentials are bad.")
    end

    it 'will return an error if email is not unique' do
      User.create(name: 'Adam Frankenstein', email: 'not-frankenstein@gmail.com', password: 'password', password_confirmation: 'password')
      visit root_path

      click_link "Register as a User"

      expect(page).to_not have_content("Sorry, your credentials are bad.")

      fill_in(:user_name, with: "Frankenstein's Monster")
      fill_in(:user_email, with: 'not-frankenstein@gmail.com')
      fill_in(:user_password, with: 'password')
      fill_in(:user_password_confirmation, with: 'password')
      click_on('Register User')

      expect(current_path).to eq('/register')
      expect(page).to have_content("Sorry, your credentials are bad.")
    end
  end
end
