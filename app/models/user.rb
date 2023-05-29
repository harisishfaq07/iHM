class User < ApplicationRecord
  attr_accessor :confirm_password , :new_password
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
# Associations
  has_many :payments , dependent: :destroy
  has_many :user_packages , dependent: :destroy
  has_one :lockable , dependent: :destroy
  has_one :family , dependent: :destroy
  has_many :tasks , dependent: :destroy
  # has_one :stripe_accounts , dependent: :destroy
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
     return  "#{Time.now.strftime("%Y").to_i - dateofbirth.to_i} "+"years"
  end

  def days_left
     valid_till = payment_date.to_i + 30
     days_left = valid_till - Time.now.strftime("%d").to_i
     if days_left < 5
      return "Please do your payment, After #{days_left} days your account will be locked"
      else
      return "#{days_left}" + " days left" 
    end
  end

  def active_contacts(user)
    if user.family.present?
    return FamilyMember.where(family_id: user.family.id).joins(:family).count
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["active_token", "admin", "country", "created_at", "dateofbirth", "email", "encrypted_password", "first_name", "gender", "id", "last_name", "parent_id", "payment", "payment_date", "remember_created_at", "reset_password_sent_at", "reset_password_token", "status", "updated_at"]
  end

  def self.allowed_members(user)
    @user = user
    pkg_id = UserPackage.find_by(user_id: @user.id).package_id
    return Package.find(pkg_id).contacts_allowed
  end

  def self.no_of_family_members(user)
     FamilyMember.all.where(family_id: user.family.id).count
  end
end
