class UserMailer < ApplicationMailer

    def activate_account(user, token)
        @user = user
        @token = token
        mail(to: @user.email, subject: 'Hi #{@user.first_name}, Please activate your account')
    end

    def payment_reminder(user)
      @user = user
      @link = "http://localhost:3000/payments/payment?id=#{@user.id}"
      mail(to: @user.email, subject: 'Hi #{@user.first_name}, Please activate your account')
    end

    def send_activate_account(user, token)
      @user = user
      @token = token
      @link = "http://localhost:3000/user/activate_account?id=#{@user.id}"
      mail(to: @user.email, subject: 'Hi #{@user.first_name}, Please activate your account')
    end

    def add_user(user, password)
      @user = user
      @password = password
      mail(to: @user.email, subject: 'Welcome to the iHouseManagement')
    end
end
