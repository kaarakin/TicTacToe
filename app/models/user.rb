class User < ApplicationRecord
  validates :email, :password, format: {
    with: /\A\S.{0,}\S\z/,
    message: ': Пробел не допустим в начале или конце строки'
  }
  validates :password, format: {
    with: /\d/,
    message: ': Пароль должен содержать хотя бы одну цифру'
  }
  validates :password, format: {
    with: /[a-z]/,
    message: ': Пароль должен содержать хотя бы один строчный символ'
  }
  validates :password, format: {
    with: /[A-Z]/,
    message: ': Пароль должен содержать хотя бы один прописной символ'
  }
  validates_presence_of :email, :password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
