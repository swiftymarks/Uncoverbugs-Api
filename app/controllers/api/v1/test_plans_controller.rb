module Api
  module V1
    class TestPlansController < ApplicationController
      before_action :authenticate_request
      rescue_from ApiExceptions::TestPlanError::RoleMismatchError, :with => :render_unauthorized
      rescue_from ApiExceptions::TestPlanError::MySQLSaveError, :with => :render_server_error
      rescue_from ApiExceptions::TestPlanError::DeviceNotFoundError, :with => :not_found
      rescue_from ApiExceptions::TestPlanError::TestPlanNotFoundError, :with => :not_found      

      def create_test_plan
        raise ApiExceptions::TestPlanError::RoleMismatchError.new if @current_user.user_type != "company"
        @project = Project.find(add_test_plan_params[:project_id])
        @new_test_plan = TestPlan.new(testing_url: add_test_plan_params[:testing_url], step_explanation: add_test_plan_params[:step_explanation],
                                      name: add_test_plan_params[:name], minimum_time: add_test_plan_params[:minimum_time], is_fix: add_test_plan_params[:is_fix],
                                      script_file: add_test_plan_params[:script_file], testing_type: add_test_plan_params[:testing_type])  
        @new_test_plan.project = @project
        @project.test_plans.push(@new_test_plan)
        raise ApiExceptions::TestPlanError::MySQLSaveError if !@project.save
        @status = :created
        @message = "Test Plan created"
        render status: :created        
      end
      
      def fetch_test_plans
        raise ApiExceptions::TestPlanError::RoleMismatchError.new if @current_user.user_type != "company"
        @project = Project.find(fetch_test_plans_params[:project_id])
        @test_plans = @project.test_plans
        @status = :ok
        @message = "Test Plan created"
      end
      
      def update_test_plan
        raise ApiExceptions::TestPlanError::RoleMismatchError.new if @current_user.user_type != "company"        
        @test_plan = TestPlan.find(update_test_plan_params[:id])
        if update_test_plan_params[:testing_url]
          @test_plan.testing_url = update_test_plan_params[:testing_url]
        end
        
        if update_test_plan_params[:step_explanation]
          @test_plan.step_explanation = update_test_plan_params[:step_explanation]          
        end
        
        if update_test_plan_params[:name]
          @test_plan.name = update_test_plan_params[:name]          
        end
        
        if update_test_plan_params[:minimum_time]
          @test_plan.minimum_time = update_test_plan_params[:minimum_time]          
        end
        
        if update_test_plan_params[:is_fix]
          @test_plan.is_fix = update_test_plan_params[:is_fix]          
        end
        
        if update_test_plan_params[:testing_type]
          @test_plan.testing_type = update_test_plan_params[:testing_type]          
        end
        
        if update_test_plan_params[:script_file]
          @test_plan.script_file = update_test_plan_params[:script_file]          
        end
        
        raise ApiExceptions::TestPlanError::MySQLSaveError.new if !@test_plan.save        
        @status = :ok
        @message = "Test plans successfully updated"
      end
      
      def delete_test_plan
        raise ApiExceptions::TestPlanError::RoleMismatchError.new if @current_user.user_type != "company"        
        @test_plan = TestPlan.find(delete_test_plan_params[:id])
        raise ApiExceptions::TestPlanError::MySQLSaveError.new if !@test_plan.destroy
        @status = :ok
        @message = "Test Plan Deleted"
      end

      def add_test_plan_device
        raise ApiExceptions::TestPlanError::RoleMismatchError.new if @current_user.user_type != "company"
        @device = Device.find(add_device_params[:device_id])
        @test_plan = TestPlan.find(add_device_params[:test_plan_id])
        raise ApiExceptions::TestPlanError::DeviceNotFoundError.new if @device == nil       
        raise ApiExceptions::TestPlanError::TestPlanNotFoundError.new if @test_plan == nil
        @test_plan.devices.push(@device)
        raise ApiExceptions::TestPlanError::MySQLSaveError.new if !@test_plan.save        
        @status = :created
        @message = "Device Added"
        render status: :created                
      end

      def remove_test_plan_device
        raise ApiExceptions::TestPlanError::RoleMismatchError.new if @current_user.user_type != "company"
        @device = Device.find(add_device_params[:device_id])
        @test_plan = TestPlan.find(add_device_params[:test_plan_id])
        raise ApiExceptions::TestPlanError::DeviceNotFoundError.new if @device == nil       
        raise ApiExceptions::TestPlanError::TestPlanNotFoundError.new if @test_plan == nil
        @test_plan.devices.push(@device)
        @status = :created
        @message = "Device Added"
      end
      
      private
      def add_test_plan_params
        params.require(:test_plan).permit(:project_id, :testing_url, :step_explanation, :name, :minimum_time, :is_fix, :type, :script_file, :testing_type)
      end
      
      def fetch_test_plans_params
        params.require(:project).permit(:project_id)
      end

      def update_test_plan_params
        params.require(:test_plan).permit(:id, :testing_url, :step_explanation, :name, :minimum_time, :is_fix, :type, :script_file)        
      end

      def add_device_params
        params.require(:test_plan).permit(:test_plan_id, :device_id)                
      end
      
      def delete_test_plan_params
        params.require(:test_plan).permit(:id)
      end
    end
  end
end