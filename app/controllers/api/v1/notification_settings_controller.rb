module Api
  module V1
    class NotificationSettingsController < ApplicationController
      before_action :authenticate_request
      rescue_from ApiExceptions::NotificationSettingError::RoleMismatchError, :with => :render_bad_request
      rescue_from ApiExceptions::NotificationSettingError::MySQLSaveError, :with => :render_server_error

      def fetch_notification_setting
        raise ApiExceptions::NotificationSettingError::RoleMismatchError.new if @current_user.user_type != "tester"
        @status = :ok
        @message = "Notification Settings Fetched"
      end
      
      def update_notification_setting
        raise ApiExceptions::NotificationSettingError::RoleMismatchError.new if @current_user.user_type != "tester"
        @notification_setting = @current_user.tester.notification_setting

        if update_notification_params[:newsletter]
          @notification_setting.newsletter = update_notification_params[:newsletter]
        end

        if update_notification_params[:notify_new_project]
          @notification_setting.newsletter = update_notification_params[:notify_new_project]          
        end

        if update_notification_params[:notify_work_evaluation]
          @notification_setting.newsletter = update_notification_params[:notify_work_evaluation]          
        end

        if update_notification_params[:notify_events]
          @notification_setting.newsletter = update_notification_params[:notify_events]          
        end
    
        raise ApiExceptions::NotificationSettingError::MySQLSaveError.new if !@notification_setting.save
        @status = :ok
        @message = "Notification Settings Updated"
      end

      private
      def update_notification_params
        params.require(:notification_setting).permit(:newsletter, :notify_new_project, :notify_work_evaluation, :notify_events)
      end
    end
  end
end