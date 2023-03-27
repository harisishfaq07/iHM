class UserPackage < ApplicationRecord
    validates :user_id, :package_id , presence: true
   
end
