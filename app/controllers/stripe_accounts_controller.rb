class StripeAccountsController < ApplicationController
    before_action :authenticate_user!

    def new
        @stripe = StripeAccount.new
    end
    
    def create
        @stripe = StripeAccount.new(email: params[:stripe_account]["email"],
                                    p_key: params[:stripe_account]["p_key"],
                                    s_key: params[:stripe_account]["s_key"])
        if @stripe.save
            flash.notice = "Successfully account created!"
            redirect_to stripe_accounts_path
        else
            flash.alert = "Error try again!"
            render 'new'
        end
    end

    def edit
        @stripe = StripeAccount.find(params[:id])
    end

    def update
        @stripe = StripeAccount.find(params[:id])
        if @stripe.present?
          if @stripe.update(email: params[:stripe_account]["email"],
                           p_key: params[:stripe_account]["p_key"],
                           s_key: params[:stripe_account]["s_key"])

            flash.notice = "Successfully account updated!"
            redirect_to stripe_accounts_path
          else
            flash.alert = "Error try again!"
            render 'edit'
          end
        end
    end

    def index
        @stripeAccounts = StripeAccount.all
    end

    def destroy
        @stripe = StripeAccount.find(params[:id])
        if @stripe.destroy
            flash.notice = "Successfully account deleted!"
            redirect_to stripe_accounts_path
        end
    end
end
