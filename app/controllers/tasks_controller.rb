class TasksController < ApplicationController
    before_action :authenticate_user!

    def new
       @task = Task.new
       if current_user.parent_id == 0
          @members = FamilyMember.all.where(family_id: current_user.family.id).joins(:family) 
          @tasks = current_user.tasks
       else
          @tasks = FamilyMember.find_by_email(current_user.email).tasks 
       end
    end


    def create
        if current_user.parent_id == 0
            # debugger
          if params[:task]["assign_to"].present?
            @task = Task.new(task_name: params[:task]["task_name"], task_desc: params[:task]["task_desc"], dead_time: params[:task]["dead_time"], dead_day: params[:task]["dead_day"],  member_id: params[:task]["assign_to"] , assign_to: params[:task]["assign_to"] )
          else
            @task = Task.new(task_name: params[:task]["task_name"], task_desc: params[:task]["task_desc"] ,dead_time: params[:task]["dead_time"], dead_day: params[:task]["dead_day"], user_id: current_user.id )
          end
            if @task.save 
                flash.notice = "Task Created Successfully"
                redirect_to tasks_new_path
            end

        else 
                @member_id = FamilyMember.find_by_email(current_user.email).id
                @task = Task.new(task_name: params[:task]["task_name"], task_desc: params[:task]["task_desc"], dead_time: params[:task]["dead_time"], dead_day: params[:task]["dead_day"], member_id: @member_id )
        end
    end


    def user_schedule
        # debugger
        @tasks = Task.all.where(member_id: params[:id])
    end


end
