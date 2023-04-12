class Task < ApplicationRecord
belongs_to :user , optional: true
belongs_to :family_member , optional: true
end
