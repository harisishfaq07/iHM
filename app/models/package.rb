class Package < ApplicationRecord
    # Validations
    validates :name, :contacts_allowed, :price, presence: true
end
