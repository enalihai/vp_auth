class User < ApplicationRecord
  has_many :user_view_parties
  has_many :view_parties, through: :user_view_parties

  validates_presence_of :name
  validates_presence_of :email
end