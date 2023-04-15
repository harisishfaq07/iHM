class ApplicationController < ActionController::Base
  
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :schedule_expiration # Manual Job
    before_action :account_lock_status , if: :user_signed_in?

 # Controller Actions
    def regenerate_token(id) #for controller
          @user = User.find(id)
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


     def account_lock_status
       @parent =  User.find(current_user.parent_id) if current_user.parent_id != 0
          if @parent.present? && @parent.lockable.present?
               sign_out current_user 
          elsif current_user.lockable.present?
               sign_out current_user
          end
     end

     def schedule_expiration
          UpdatePayment.perform_now
     end
    protected

         def configure_permitted_parameters
              devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :first_name, :last_name, :gender, :country, :parent_id, :dateofbirth)}

              devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :first_name, :last_name, :gender, :country, :parent_id, :dateofbirth)}
         end

end
