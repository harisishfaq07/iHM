class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
# Associations
  has_many :payments , dependent: :destroy
  has_many :user_packages , dependent: :destroy
  has_one :lockable , dependent: :destroy
# Validations
validates :email, uniqueness: true

  # UpdatePayment.perform_now

  def full_name
    if first_name.present? && last_name.present?
      first_name + " " + last_name
    end
  end

  def package_name
    if user_packages.present?
     user_payment = user_packages.last
     package_detail = Package.find(user_payment.package_id)
     package_detail.name
    else
      return "User has no package"
    end
  end

  def user_price_paid
    if user_packages.present?
      user_payment = user_packages.last
      package_detail = Package.find(user_payment.package_id)
      "#{package_detail.price}" + "$"
     else
       return "User has no package"
     end
  end

  def contacts_allowed
    if user_packages.present?
      user_payment = user_packages.last
      package_detail = Package.find(user_payment.package_id)
      package_detail.contacts_allowed
     else
       return "User has no package"
     end
  end

  def age
     return  Time.now.strftime("%Y") - dateofbirth.strftime("%Y")
  end

  def days_left
     valid_till = payment_date.to_i + 10
     days_left = valid_till - Time.now.strftime("%d").to_i
     if days_left < 5
      return "Please do your payment, After #{days_left} days your account will be locked"
      else
      return "#{days_left}" + " days left" 
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["active_token", "admin", "country", "created_at", "dateofbirth", "email", "encrypted_password", "first_name", "gender", "id", "last_name", "parent_id", "payment", "payment_date", "remember_created_at", "reset_password_sent_at", "reset_password_token", "status", "updated_at"]
  end
end
