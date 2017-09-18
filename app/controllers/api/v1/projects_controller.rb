module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authenticate_request
      rescue_from ApiExceptions::ProjectError::RoleMismatchError, :with => :render_unauthorized      
      rescue_from ApiExceptions::ProjectError::MySQLSaveError, :with => :render_server_Error      
      
      def fetch_projects
        raise ApiExceptions::ProjectError::RoleMismatchError.new if @current_user.user_type != "company"
        @projects = @current_user.company.projects
        @status = :ok
        @message = "Fetch User's Projects"
      end
      
      def create_new_project
        raise ApiExceptions::ProjectError::RoleMismatchError.new if @current_user.user_type != "company"
        @new_project = Project.new(create_new_project_params)
        @new_project.company = @current_user.company
        @new_project.save
        raise ApiExceptions::ProjectError::MySQLSaveError.new if !@new_project.save        
        @current_user.company.projects.push(@new_project)
        raise ApiExceptions::ProjectError::MySQLSaveError.new if !@current_user.save
        @status = :created
        @message = "Project created"
        render status: :created
      end
      
      def update_project
        raise ApiExceptions::ProjectError::RoleMismatchError.new if @current_user.user_type != "company"
        @project = Project.find(update_new_project_params[:id])
        
        if update_new_project_params[:name]                    
          @project.name = update_new_project_params[:name]
        end
        
        if update_new_project_params[:testing_type]                              
          @project.testing_type = update_new_project_params[:testing_type]
        end
        
        if update_new_project_params[:version]                              
          @project.version = update_new_project_params[:version]
        end
        
        if update_new_project_params[:testing_site]                              
          @project.testing_site = update_new_project_params[:testing_site]
        end
        
        if update_new_project_params[:objective]                              
          @project.objective = update_new_project_params[:objective]
        end
        
        if update_new_project_params[:language]                              
          @project.language = update_new_project_params[:language]
        end
        
        if update_new_project_params[:result_email]                              
          @project.result_email = update_new_project_params[:result_email]
        end
        
        raise ApiExceptions::ProjectError::MySQLSaveError.new if !@project.save
        @status = :ok
        @message = "Project fields updated"
      end
      
      private
      def create_new_project_params
        params.require(:project).permit(:name, :testing_type, :version, :testing_site, :objective, :language, :result_email)
      end
      
      def update_new_project_params
        params.require(:project).permit(:id, :name, :testing_type, :version, :testing_site, :objective, :language, :result_email)
      end
    end
  end
end