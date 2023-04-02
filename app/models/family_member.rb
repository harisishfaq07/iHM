class FamilyMember < ApplicationRecord
    belongs_to :family

    validates :email , :uniqueness => true 
end