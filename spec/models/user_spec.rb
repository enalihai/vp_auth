require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:user_view_parties) }
    it { should have_many(:view_parties).through(:user_view_parties) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'password authorization' do
    it 'tests the new user to check password_digest was created' do
      user = User.create(name: 'Auth Tests', email: 'auth@gmail.com', password: 'password', password_confirmation: 'password')
      expect(user).to be_a(User)
      expect(user.name).to eq('Auth Tests')
      expect(user.email).to eq('auth@gmail.com')
      expect(user.password_digest).present?
      expect(user.password_digest).to_not eq('password')
      expect(user.save).to be(true)
    end

    it 'checks sad paths of our attributes' do
      user = User.create(name: '', 
                  email: 'auth@gmail.com', 
                  password: 'password', 
                  password_confirmation: 'password')
      expect(user.save).to be(false)
    
      user = User.create(name: 'Auth Tests', 
                  email: '', 
                  password: 'password', 
                  password_confirmation: 'password')

      expect(user.save).to be(false)

      user = User.create(name: 'Auth Tests', 
                  email: 'auth@gmail.com', 
                  password: '', 
                  password_confirmation: 'password')

      expect(user.save).to be(false)

      user = User.create(name: 'Auth Tests', 
                  email: 'auth@gmail.com', 
                  password: 'password', 
                  password_confirmation: '')

      expect(user.save).to be(false)
    end
  end
end
