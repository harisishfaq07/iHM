class IhmController < ApplicationController
    before_action :authenticate_user! , only: [:dashboard]
    def homepage
        # homepage-view
    end

    def dashboard
    end
end
