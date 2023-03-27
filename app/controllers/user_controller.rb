class UserController < ApplicationController
  before_action :authenticate_user! , except: [:signup, :activate_account, :do_activate_account, :regenerate_active_token]

  require 'securerandom'
  def signup
    @user = User.find_by_email(params[:user]["email"])
    if @user.present?
    if @user.payment == 0 
        flash[:alert] = "Users already registered, Please complete your payment!"
        redirect_to payments_payment_path(id: @user.id)
    elsif @user.status == 0
      flash[:alert] = "Users already registered and payment is already done, Please activate your account!"
      regenerate_token(@user.id)
    elsif @user.status == 1 && @user.payment == 1
      flash[:notice] = "Your account is already setup, you can login now!"
      redirect_to new_user_session_path
    end
    else
      @user = User.new()
      param = params[:user]
      @user.first_name = param["first_name"]
      @user.last_name = param["last_name"]
      @user.email = param["email"]
      @user.password = param["password"]
      @user.gender = param["gender"]
      @user.country = param["country"]
      @user.dateofbirth = param["dateofbirth"]
      if @user.save
        flash[:notice] = "Step 1 Completed Successfully!"
        redirect_to payments_payment_path(id: @user.id)
      end
  end
  end


  def activate_account
    @error = 0
    @user = User.find(params[:id])
  end

  def do_activate_account
    @user = User.find(params[:user]["id"])
    if @user.status == 0
    if @user.active_token == params[:user]["active_token"]
      @user.update(status: 1)
      flash[:notice] = "Congratulations, your account is fully activated, you can login now!"
      redirect_to new_user_session_path
    else
      @error = 1
      flash.alert = "Secret key is invalid!"
      render 'activate_account'
    end
  else
      flash[:notice] = "Your Account is already Activated, you can login now"
      redirect_to new_user_session_path
  end
  end

  

  def regenerate_active_token
   @user = User.find(params[:id])

   if @user.status == 0
    random_string = SecureRandom.hex(8)
    @user.update(active_token: random_string)
    UserMailer.activate_account(@user,random_string).deliver_later
    flash.notice = "Your token is regenerated kindly check your email!"
    redirect_to user_activate_account_path(id: @user.id)
 else
   flash.alert = "Please try again!"
   redirect_to new_user_session_path
 end
  
  end
end
