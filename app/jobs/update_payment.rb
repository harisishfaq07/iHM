class UpdatePayment < ApplicationJob

    def perform
      u = User.all.where(payment: 1, status: 1, admin: 0)
      u.each do |u|
        if u.payment_date.present? 
            valid_till = u.payment_date.to_i + 10
            remaining_days = valid_till - Time.now.strftime("%d").to_i
            if remaining_days == 0
                u.update(payment_date: nil, payment: 0)
                Lockable.create(user_id: u.id, status: 1, reason: "Monthly subscription ends")
                pkg = UserPackage.all.where(user_id: u.id)
                if pkg.present? 
                   pkg.destroy_all
                end
            end
        end
    end
    end

end