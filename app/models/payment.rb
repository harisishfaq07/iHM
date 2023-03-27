class Payment < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates :user_id, :package_no, :card_no, :cvc, :brand, :exp_month, :exp_year, presence: true , if: :check_package?
  
  def check_package?
    pkg = Package.find(package_no)
    if pkg.name.downcase == "free"
      return false
    else
      true
    end
  end
end
