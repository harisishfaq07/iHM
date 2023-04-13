
module Admin
    class AdminsController < ApplicationController

    def admin_dashboard
        @approved = User.all.where(status: 1, payment:1).count
        @notapproved = User.all.where(status: 0).count
        @notpaid = User.all.where(payment: 0).count
    end

end
end