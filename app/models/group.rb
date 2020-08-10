class Group < ApplicationRecord
  has_secure_password
  has_many :users, dependent: :destroy
  has_many :items, dependent: :destroy

  attr_reader :name
  attr_reader :password
end
