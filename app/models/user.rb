class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable 

  has_many :reviews, dependent: :destroy_async
  has_many :comments, dependent: :destroy_async

  validates :account_type, :inclusion => { :in => [0, 1, 2] }

  
end
