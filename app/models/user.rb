class User < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_secure_password #password_digestにpasswordを保存
  validates :password, presence: true
  
  # 渡された文字列のハッシュ値を返す
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
end
