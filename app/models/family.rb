class Family < ApplicationRecord
    belongs_to :user
    has_many :family_members , dependent: :destroy
    # serialize :user_id
end