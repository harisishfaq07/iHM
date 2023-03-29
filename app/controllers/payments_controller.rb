class PaymentsController < ApplicationController
  require 'securerandom'

  def payment
    @user = User.find(params[:id])
    @payment = Payment.new()
  end

  def create_payment
    @payment = Payment.new()
    @user = User.find(params[:payment]["user_id"])
    package_id = params[:payment]["package_no"]

    if Package.find(package_id).name.downcase != "free"
        stripe_token = Payment.get_token(params[:payment]["card_no"],
                                        params[:payment]["exp_month(2i)"],
                                        params[:payment]["exp_year(1i)"],
                                        params[:payment]["cvc"])
      
        if stripe_token != false
          do_payment = Payment.process_payment(@user.email, stripe_token, package_id)
          
          if do_payment
              @payment.user_id = params[:payment]["user_id"]
              @payment.package_no = params[:payment]["package_no"]
              @payment.card_no = params[:payment]["card_no"]
              @payment.cvc = params[:payment]["cvc"]
              @payment.exp_month = params[:payment]["exp_month(2i)"]
              @payment.exp_year = params[:payment]["exp_year(1i)"]
              @payment.brand = params[:payment]["brand"]
              @payment.status = 1
                if @payment.save
                  UserPackage.create(user_id: @payment.user.id, package_id: @payment.package_no)
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
                else
                  flash.alert = "Please try again!"
                  render 'payment'
                end
            else
              flash.alert = "Please try again!"
              render 'payment'
            end
        else
          flash.alert = "Invalid Card Details"
          render 'payment'
        end
    else
      random_string = SecureRandom.hex(8)
      @user.update(active_token: random_string, payment: 0)
      UserMailer.activate_account(@user,random_string).deliver_later
      flash.notice = "Congratulations! step 2 successfully completed"
      redirect_to user_activate_account_path(id: @user.id)
    end

  end #create_payment
end

