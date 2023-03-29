class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
# Associations
  has_many :payments , dependent: :destroy


# Validations
validates :email, uniqueness: true


  def full_name
    if first_name.present? && last_name.present?
      first_name + " " + last_name
    end
  end

  def package_name
    if payments.present?
     user_payment = payments.last
     package_detail = Package.find(user_payment.package_no)
     package_detail.name
    else
      return "User has no package"
    end
  end

  def user_price_paid
    if payments.present?
      user_payment = payments.last
      package_detail = Package.find(user_payment.package_no)
      return "#{package_detail.price}" + "$"
     else
       return "User has no package"
     end
  end

  def contacts_allowed
    if payments.present?
      user_payment = payments.last
      package_detail = Package.find(user_payment.package_no)
      return "#{package_detail.contacts_allowed}" + " members"
     else
       return "User has no package"
     end
  end

  def age
     return  Time.now.strftime("%Y") - dateofbirth.strftime("%Y")
  end

  def days_left
     valid_till = payment_date.to_i + 30
     days_left = valid_till - Time.now.strftime("%d").to_i
     return "#{days_left}" + " days left" 
  end

  def self.ransackable_attributes(auth_object = nil)
    ["active_token", "admin", "country", "created_at", "dateofbirth", "email", "encrypted_password", "first_name", "gender", "id", "last_name", "parent_id", "payment", "payment_date", "remember_created_at", "reset_password_sent_at", "reset_password_token", "status", "updated_at"]
  end
end
