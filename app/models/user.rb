# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_view_parties
  has_many :view_parties, through: :user_view_parties

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
end
