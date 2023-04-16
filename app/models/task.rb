class Task < ApplicationRecord
belongs_to :user , optional: true
belongs_to :family_member , optional: true

enum task_type: ["today" , "schedule" , "previous" , "complete" , "incomplete" , "pending" , "assigned"]
end
