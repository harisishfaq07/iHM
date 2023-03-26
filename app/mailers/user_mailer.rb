class UserMailer < ApplicationMailer

    def activate_account(user, token)
        @user = user
        @token = token
        mail(to: @user.email, subject: 'Hi #{@user.first_name}, Please activate your account')
      end
end
