class PaymentsController < ApplicationController
  require 'securerandom'

  def payment
    @user = User.find(params[:id])
    @payment = Payment.new()
  end


  def create_payment
    @payment = Payment.new()
    @payment.user_id = params[:payment]["user_id"]
    @payment.package_no = params[:payment]["package_no"]
    @payment.card_no = params[:payment]["card_no"]
    @payment.cvc = params[:payment]["cvc"]
    @payment.exp_month = params[:payment]["exp_month(2i)"]
    @payment.exp_year = params[:payment]["exp_year(1i)"]
    @payment.brand = params[:payment]["brand"]
    
    if @payment.save
      if @payment.user.status == 0
         random_string = SecureRandom.hex(8)
         @payment.user.update(active_token: random_string, payment: 1)
         UserMailer.activate_account(@payment.user,random_string).deliver_later
         flash.notice = "Congratulations! step 2 successfully completed"
         redirect_to user_activate_account_path(id: @payment.user.id)
      else
        flash.alert = "Please try again!"
        redirect_to new_user_session_path
      end
  end
end
end
