class UserController < ApplicationController
  before_action :authenticate_user! , except: [:signup, :activate_account, :do_activate_account, :regenerate_active_token]

  require 'securerandom'

  def new_user #get
      @user = User.new()
      @approved = User.all.where(status: 1).count
      @notapproved = User.all.where(status: 0).count
      @notpaid = User.all.where(payment: 0).count
      @paid = User.all.where(payment: 1).count
      @all = User.paginate(:page => params[:page], :per_page => 10)
      @q = @all.ransack(params[:q])
      @all_users = @q.result(distinct: true)
  end

  def create_new_user #post
    password = random_string = SecureRandom.hex(6)
    @user = User.new(email: params[:user]["email"], password: password)
    if @user.save
      UserMailer.add_user(@user, password).deliver_later
      flash.notice = "USer created Successfully!"
      redirect_to user_create_new_user_path
    else
      flash.alert = "Try again!"
      render 'new_user'
    end
  end

  def signup #post
    @user = User.find_by_email(params[:user]["email"])
    if @user.present? 
    if @user.payment == 0 && @user.parent_id == 0
        flash[:alert] = "Users already registered, Please complete your payment!"
        redirect_to payments_payment_path(id: @user.id)
    elsif @user.status == 0 && @user.parent_id == 0
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


  def activate_account #get
    @error = 0
    @user = User.find(params[:id])
  end

  def do_activate_account #post
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

  def send_regenerate_active_token_email
    @user = User.find(params[:id])
 
    if @user.status == 0
     random_string = SecureRandom.hex(8)
     @user.update(active_token: random_string)
     UserMailer.send_activate_account(@user,random_string).deliver_later
     flash.notice = "Your token is regenerated kindly check your email!"
    #  redirect_to user_activate_account_path(id: @user.id)
     else
       flash.alert = "Please try again!"
       redirect_to new_user_session_path
     end
   
   end

  def verified_users
     @users = User.all.where(payment:1, status:1)
     respond_to do |format|
      format.xlsx {}
      format.html {}
     end
  end

  def view_user
     @user = User.find(params[:id])
  end

  def unapproved_users
    @users = User.all.where(status: 0)
  end

  def unpaid_users
    @users = User.all.where(payment: 0)
  end

  def delete_user
    @user = User.find(params[:id])
    if @user.payment == 1
      flash.alert = "This User is active with Payment, Can't be delete"
      redirect_to user_new_user_path 
    else

      if @user.destroy
        flash.notice = "Deleted Successfully"
        redirect_to user_new_user_path 
      else
        flash.alert = "try again!"
        redirect_to user_new_user_path
      end
    end
  end

  def delete_member
      @member = FamilyMember.find(params[:id])
      @user = User.find_by_email(@member.email)
      @member.status = 0
      if @member.save
        @user.destroy if @user.present?
        FamilyMember.all.where(status: 0).delete_all
        flash.notice = "Member deleted successfully!"
        redirect_to user_add_family_members_path
      else
        flash.alert = "Error: Try again!"
        redirect_to user_add_family_members_path
      end
  end

  def locked_user
     @users = User.joins(:lockable)
  end



  def edit_profile #get
    @user = current_user
  end

  def do_edit_profile #post
   if params[:user]["new_password"].present? && params[:user]["confirm_password"].present?
      if current_user.valid_password?(params[:user]["password"])
          if params[:user]["new_password"] == params[:user]["confirm_password"]
            current_user.update(password: params[:user]["new_password"])
            flash.alert = "Password update Successfully"
            redirect_to user_view_user_path(id: current_user.id)
          else
            flash.alert = "New password Not same. Try again!"
            redirect_to user_view_user_path(id: current_user.id)
          end
        else
          flash.alert = "Invalid old Password"
          redirect_to user_view_user_path(id: current_user.id)
        end
   else

   if current_user.update(first_name: params[:user]["first_name"] , last_name: params[:user][:last_name],
                         gender: params[:user]["gender"], country: params[:user]["country"], 
                         dateofbirth: params[:user]["dateofbirth"] , phone_no: params[:user]["phone_no"]
                         )
                         flash.notice = "Profile Updated Successfully!"
                         redirect_to user_view_user_path(id: current_user.id)
   else
    flash.alert = "Please try again!"
    render 'edit_profile'
   end
  end    
  end


  def register_family #get
    @family = Family.new
    if current_user.family.present?
       redirect_to user_add_family_members_path
    end
  end

  def do_family_register #post
      if Family.create(family_name: params[:family]["family_name"], no_of_members: params[:family]["no_of_members"], user_id: current_user.id)
        flash.notice = "Family registered Successfully"
        redirect_to user_add_family_members_path
      else
        flash.alert = "Error Try again!" 
        render 'register_family'
      end
  end
  def add_family_members
    # @members = FamilyMember.where(family_id: current_user.family.id , status: 1).joins(:family)
    @members = FamilyMember.all.where(family_id: current_user.family.id , status: 1)
  end

  def do_add_family_members
    if User.no_of_family_members(current_user) < User.allowed_members(current_user) 
      find_dup = User.find_by_email(params[:family_member]["email"])
      if !find_dup.present?
        if @member = FamilyMember.create(name: params[:family_member]["name"], email: params[:family_member]["email"],
                              gender: params[:family_member]["gender"], role: params[:family_member]["role"], alpha: params[:family_member][:alpha] ,
                              password: params[:family_member]["password"], family_id: current_user.family.id)
            User.create(first_name: @member.name, email: @member.email, gender: @member.gender, alpha: @member.alpha , password: @member.password, parent_id: current_user.id)
                              flash.notice = "#{@member.name} Add Successfully"
                              redirect_to user_add_family_members_path
        end
      else
        flash.alert = "Email already Registered"
        redirect_to user_add_family_members_path
      end
     
    else
      flash.alert = "Your members limit is full. upgrade your account to create more"
    end
  end




  def view_member
    @member = FamilyMember.find(params[:id])
  end

end
