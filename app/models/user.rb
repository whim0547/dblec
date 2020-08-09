class User < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_secure_password #password_digestにpasswordを保存

end
