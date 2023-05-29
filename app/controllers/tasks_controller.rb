class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :task_validations , :only => [:create , :do_edit_task]
    before_action :update_tasks_type , only: :new

    def new
       @task = Task.new
       @members = FamilyMember.all.where(family_id: current_user.family.id).joins(:family) if current_user.parent_id == 0
    end

    def create
      @task = Task.new
      if @dead_day >= @current_day
        if current_user.parent_id == 0
            if params[:task]["member_id"].present?
              @task = Task.new(task_name: params[:task]["task_name"], task_desc: params[:task]["task_desc"], dead_time: params[:task]["dead_time"], dead_day: @dead_day,  member_id: params[:task]["member_id"] , assigned_by: current_user.email , task_type: @task_type )
            else
              @task = Task.new(task_name: params[:task]["task_name"], task_desc: params[:task]["task_desc"] ,dead_time: params[:task]["dead_time"], dead_day: @dead_day, user_id: current_user.id , task_type: @task_type)
            end
              if @task.save 
                  flash.notice = "Task Created Successfully"
                  redirect_to tasks_new_path
              end
          else 
                  @member_id = FamilyMember.find_by_email(current_user.email).id
                  @task = Task.new(task_name: params[:task]["task_name"], task_desc: params[:task]["task_desc"], dead_time: params[:task]["dead_time"], dead_day: @dead_day, member_id: @member_id , task_type: @task_type)
                  if @task.save 
                    flash.notice = "Task Created Successfully"
                    redirect_to tasks_new_path
                  end
          end
        else
          flash.alert = "You can not create task on Previous Days. Please create for today or for next days"
          redirect_to tasks_new_path
        end
    end #create_end

    def user_tasks
      if current_user.parent_id == 0
         @tasks = current_user.tasks.where(task_type: params[:type])
      else
        @member = FamilyMember.find_by_email(current_user.email)
        @tasks  = Task.all.where(task_type: params[:type]).where(member_id: @member.id)
      end
      respond_to do |format|
          format.js {@tasks }
          format.html
      end
    end

    def user_schedule #list members Task
      @tasks = Task.all.where(member_id: params[:id])
    end

    def edit_task
      @task = Task.find(params[:id])
      @members = current_user.family.family_members if current_user.family.present? 
    end

    def do_edit_task
      @task = Task.find(params[:id])
      if @dead_day >= @current_day
        if params[:task]["member_id"].present?
          @memberTask = Task.new(task_name: params[:task]["task_name"], task_desc: params[:task]["task_desc"], dead_time: params[:task]["dead_time"], dead_day: @dead_day,  member_id: params[:task]["member_id"] , assigned_by: current_user.email , task_type: @task_type )
          if @memberTask.save
             @task.destroy
             flash.notice = "Task update Successfully!"
             redirect_to tasks_new_path
          end
        else
          @task.update(task_name: params[:task]["task_name"], task_desc: params[:task]["task_desc"] ,dead_time: params[:task]["dead_time"], dead_day: @dead_day, task_type: @task_type)
          flash.notice = "Task update Successfully!"
          redirect_to tasks_new_path
        end

      else
        flash.alert = "You can not edit task on Previous Days. Please create for today or for next days"
        redirect_to tasks_edit_task_path
      end

    end #do_edit_task_end

    def delete_task
      @task = Task.find(params[:id])
      delete = @task.destroy ? true : false if @task.present?
      if delete
        flash.notice = "Delete Successfully"
        redirect_to tasks_new_path
      else
        flash.alert = "Please try again!"
        redirect_to tasks_new_path
      end
    end

    private
    def task_validations
        @dead_day =  params[:task][:dead_day].present? ? params[:task][:dead_day] : Time.now.strftime("%Y-%m-%d")
        @task_type = @dead_day == Time.now.strftime("%Y-%m-%d") ? 0 : 1
        @current_day = Time.now.strftime("%Y-%m-%d")
        @previous_day = Time.now.prev_day
        @next_day = Time.now.next_day 
    end

    def update_tasks_type
      if current_user.parent_id == 0
         @tasks = current_user.tasks
      else
        @member = FamilyMember.find_by_email(current_user.email)
        @tasks = Task.all.where(member_id: @member.id)
      end

      @current_day = Time.now.strftime("%Y-%m-%d")
      @tasks.each do |t|
          if t.dead_day < @current_day
             t.previous!
          elsif t.schedule? && t.dead_day == @current_day
             t.today!
          end
      end
    end

end
