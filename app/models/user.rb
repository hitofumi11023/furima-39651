class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :first_name,
  format: { with: /\A([ぁ-んァ-ン一-龥]|ー)+\z/, message: '名前は全角で入力してください' },
  presence: true
  validates :last_name,
  format: { with: /\A([ぁ-んァ-ン一-龥]|ー)+\z/, message: '名字は全角で入力してください' },
  presence: true
  validates :first_name_kana,
  format: { with: /\A([ァ-ン]|ー)+\z/, message: '名前（カナ）は全角（カタカナ）で入力してください' },
  presence: true
  validates :last_name_kana,
  format: { with: /\A([ァ-ン]|ー)+\z/, message: '名字（カナ）は全角（カタカナ）で入力してください' },
  presence: true
  validates :birth_date, presence: true
  validates :email,
  format: { with: /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\z/, message: 'メールアドレスは、＠を含む英数字で入力してください' }
  validates :password, 
  format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze, message: 'パスワードは6文字以上の半角英数字で入力してください' }

end
