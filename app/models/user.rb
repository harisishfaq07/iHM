class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
# Associations
  has_many :payments , dependent: :destroy
  has_one :package , dependent: :destroy #at a time user can have only one package

# Validations
# validates :email, :first_name, :last_name, :password, presence: true
validates :email, uniqueness: true
end
