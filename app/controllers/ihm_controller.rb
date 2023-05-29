class IhmController < ApplicationController
    before_action :authenticate_user! , only: [:dashboard]
    def homepage
        # homepage-view
    end

    def dashboard
    end

    def child_dash
    end

    def perform_job
        ChargeUser.perform_in(10)
    end
end
