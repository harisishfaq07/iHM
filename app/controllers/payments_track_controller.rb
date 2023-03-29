class PaymentsTrackController < ApplicationController
before_action :authenticate_user!

    def all_payments
        @payments = Payment.all.where(status: 1)
        respond_to do |format|
            format.xlsx { }
            format.html { }
          end
    end

    def up_coming_payments
       @payments = User.all.where(payment: 0)
    end

    def send_payment_reminder
        @user = User.find(params[:id])
        if @user.payment == 0
            UserMailer.payment_reminder(@user).deliver_later
                      flash.notice = "Reminder Sent"
                      redirect_to payments_track_up_coming_payments_path
        end
    end
end
