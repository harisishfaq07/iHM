class SessionsController < Devise::SessionsController

    def login
        @user = User.find_by_email(params[:user]["email"])
        if @user.lockable.present?
            flash.alert = "Your account is locked due to #{@user.lockable.reason}"
            redirect_to payments_payment_path(id: @user.id)
        else
        if @user.present? && @user.valid_password?(params[:user]["password"])
        if @user.payment == 0 && @user.parent_id == 0
            flash.alert = "Please do your payment to continue..." 
            redirect_to payments_payment_path(id: @user.id)
        elsif @user.status == 0 && @user.parent_id == 0
            flash.alert = "Your account is inactive please activate your account, please check your email for secret key"
            regenerate_token(@user.id)   
         else
                if @user.admin == 1

                    flash.notice = "Welcome #{@user.email}!" 
                    sign_in @user
                    redirect_to admin_dashboard_path
                else
                    flash.notice = "Welcome #{@user.email}!"
                    sign_in @user
                    redirect_to  ihm_dashboard_path
                end
            end
        else
                flash.alert = "Invalid email/password"
        end
    end
    end


    # private
    # def params
    #     params.require(:user).permit!
    # end
end
