class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :transactions
  has_many :stocks
end
