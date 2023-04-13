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
 
  def self.create_stripe_customer(email, token)
      customer = Stripe::Customer.create email: email , card: token
      customer ? customer : false
  end

  def self.process_payment(email, token, package_id)
        customer = Payment.create_stripe_customer(email, token) #create customer
        package = Package.find(package_id)
        payment = Stripe::Charge.create customer: customer.id,
                  amount: (package.price * 100), 
                  description: package.name,
                  currency: 'usd' 

        payment ? true : false
  end


  def self.get_token(card_no, exp_month, exp_year, cvc)
      token =  Stripe::Token.create({
        card: {
          number: card_no,
          exp_month: exp_month,
          exp_year: exp_year,
          cvc: cvc,
        }
      })

    token.present? ? token.id : false
  end
end
