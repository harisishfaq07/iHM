class FamilyMember < ApplicationRecord
    belongs_to :family
    has_many :tasks , dependent: :destroy
    validates :email , :uniqueness => true 
end