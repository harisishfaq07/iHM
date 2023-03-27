class PackagesController < ApplicationController
    before_action :authenticate_user!
    def index
        @packages = Package.all 
        respond_to do |format|
            format.xlsx {
            #   response.headers[
            #     'Content-Disposition'
            #   ] = "attachment; filename='packages.xlsx'"
            }
            format.html { }
          end
    end

    def new
       @package = Package.new
    end

    def create
        @package = Package.new(name: params[:package]["name"],
                               contacts_allowed: params[:package]["contacts_allowed"],
                               price: params[:package]["price"])

        if @package.save
            flash.notice = "Package created Successfully"
            redirect_to packages_path
        else
            flash.alert = "Please try again!"
            render 'new'
        end
    end
   
    def edit
        @package = Package.find(params[:id])
    end

    def update
        @package = Package.find(params[:id])
        if @package.present?
            if @package.update(name: params[:package]["name"],
                               contacts_allowed: params[:package]["contacts_allowed"],
                               price: params[:package]["price"])
                flash.notice = "Successfully updated!"
                redirect_to packages_path
            else
                flash.alert = "Please try again!"
                render 'edit'
            end
        end
    end

def destroy
    @package = Package.find(params[:id])
    if @package.destroy
        flash.notice = "Successfully deleted!"
        redirect_to packages_path
    end

end


end
