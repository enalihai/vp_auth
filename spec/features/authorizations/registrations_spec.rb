require 'rails_helper'

RSpec.describe 'User Registrations' do
    describe "'GET /register'"  do
        it 'registrations#new :: has form for creating User' do
            visit root_path

            click_on "Register as a User"

            expect(current_path).to eq('/register')

            email = "HazelTheCat@meow.com"
            name = "Hazel the Cat"
            meow = "meow"

            fill_in(:name, with: name)
            fill_in(:email, with: email)
            fill_in(:password, with: meow)
            fill_in(:password_confirmation, with: meow)

            click_on 'Register User'
        
            expect(page).to have_content(email)
            expect(current_path).to eq('/dashboard')
        end

        it 'will return an error if name is missing' do
            visit root_path

            click_link "Register as a User"

            expect(page).to_not have_content("Sorry, your credentials are bad.")

            fill_in(:name, with: "")
            fill_in(:email, with: 'not-frankenstein@gmail.com')
            fill_in(:password, with: 'password')
            fill_in(:password_confirmation, with: 'password')
            click_on('Register User')
#need to add relations and validations 
            expect(current_path).to eq('/register')
            expect(page).to have_content("Invalid registration credentials.")
            end

        it 'will return an error if email is missing' do
            visit root_path

            click_link "Register as a User"

            expect(page).to_not have_content("Invalid registration credentials.")

            fill_in(:name, with: "Frankenstein's Monster")
            fill_in(:email, with: '')
            fill_in(:password, with: 'password')
            fill_in(:password_confirmation, with: 'password')
            click_on('Register User')

            expect(current_path).to eq('/register')
            expect(page).to have_content("Invalid registration credentials.")
            end

        it 'will return an error if email is not unique' do
            User.create(name: 'Adam Frankenstein', email: 'not-frankenstein@gmail.com', password: 'password', password_confirmation: 'password')
            visit root_path

            click_link "Register as a User"

            expect(page).to_not have_content("Invalid registration credentials.")

            fill_in(:name, with: "Frankenstein's Monster")
            fill_in(:email, with: 'not-frankenstein@gmail.com')
            fill_in(:password, with: 'password')
            fill_in(:password_confirmation, with: 'password')
            click_on('Register User')

            expect(current_path).to eq('/register')
            expect(page).to have_content("Invalid registration credentials.")
            end

            it 'registrations#create :: User Registration'
            it 'sets an attribute to Admin'
    end 
end