module Api
  module V1
    class ProjectModulesController < ApplicationController
      before_action :authenticate_request   
      rescue_from  ApiExceptions::ProjectModuleError::RoleMismatchError, :with => :render_unauthorized
      rescue_from  ApiExceptions::ProjectModuleError::MySQLSaveError, :with => :render_server_error
      
      def create_project_module
        raise ApiExceptions::ProjectModuleError::RoleMismatchError.new if @current_user.user_type != "company"
        @project = Project.where(id: add_project_module_params[:project_id]).first        
        @new_project_module = ProjectModule.new(name: add_project_module_params[:name])
        @project.project_modules.push(@new_project_module)
        raise ApiExceptions::ProjectModuleError::MySQLSaveError.new if !@project.save
        render status: :created
      end        

      def fetch_project_modules
        raise  ApiExceptions::ProjectModuleError::RoleMismatchError.new if @current_user.user_type != "company"
        @project = Project.where(id: fetch_project_modules_params[:project_id]).first
        @project_modules = Project.where(project)
        @status = :ok
        @message = "User's Project Modules Fetches"
      end

      private
      def add_project_module_params
        params.require(:project_module).permit(:project_id, :name)        
      end

      def fetch_project_modules_params
        params.require(:project_module).permit(:project_id)        
      end
    end
  end
end