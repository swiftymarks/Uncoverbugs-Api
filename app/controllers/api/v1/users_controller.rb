module Api
    module V1
        class UsersController < ApplicationController
            before_action :authenticate_request
            rescue_from  ApiExceptions::UserError::MySQLSaveError, :with => :render_server_error            
            rescue_from  ApiExceptions::UserError::NoTesterProfileYetError, :with => :render_not_found            
            
            def fetch_profile
                if @current_user.user_type == "tester"
                    raise ApiExceptions::UserError::NoTesterProfileYetError.new if !@current_user.tester
                end
                @status = :ok
                @message = "Profile Successfully Fetched"
            end
            
            def update_tester_profile  
                if !@current_user.tester
                    if user_params[:first_name]
                        @current_user.first_name = user_params[:first_name]
                    end
    
                    if user_params[:last_name]
                        @current_user.last_name = user_params[:last_name]                    
                    end
                    @tester = Tester.new(tester_params)
                    @current_user.tester = @tester
                    @notification_setting = NotificationSetting.new
                    @tester.notification_setting = @notification_setting
                    raise ApiExceptions::UserError::MySQLSaveError.new if !@current_user.save
                    @status = :ok
                    @message = "Tester profile successfully updated"
                end

                if user_params[:first_name]
                    @current_user.first_name = user_params[:first_name]
                end

                if user_params[:last_name]
                    @current_user.last_name = user_params[:last_name]                    
                end

                if tester_params[:address1]
                    @current_user.tester.address1 = tester_params[:address1]                    
                end

                if tester_params[:address2]
                    @current_user.tester.address2 = tester_params[:address2]                    
                end

                if tester_params[:province]
                    @current_user.tester.province = tester_params[:province]                    
                end

                if tester_params[:skype_id]
                    @current_user.tester.skype_id = tester_params[:skype_id]                    
                end

                if tester_params[:zip_code]
                    @current_user.tester.zip_code = tester_params[:zip_code]                    
                end

                if tester_params[:mobile_number]
                    @current_user.tester.mobile_number = tester_params[:mobile_number]                    
                end

                if tester_params[:gender]
                    @current_user.tester.gender = tester_params[:gender]                    
                end

                if tester_params[:born_year]
                    @current_user.tester.born_year = tester_params[:born_year]                    
                end

                if tester_params[:paypal_email]
                    @current_user.tester.paypal_email = tester_params[:paypal_email]                    
                end       

                raise ApiExceptions::UserError::MySQLSaveError.new if !@current_user.save

                @status = :ok
                @message = "Tester profile successfully updated"
            end

            def update_company_profile
                if user_params[:first_name]
                    @current_user.first_name = user_params[:first_name]
                end

                if user_params[:last_name]
                    @current_user.first_name = user_params[:last_name]
                end

                if company_params[:company_name]
                    @current_user.company.company_name = company_params[:company_name]
                end

                if company_params[:company_url]
                    @current_user.company.company_url = company_params[:company_url]
                end

                raise ApiExceptions::UserError::MySQLSaveError.new if !@current_user.save                
                @status = :ok
                @message = "Company profile successfully updated"
            end

            private
            def user_params
                params.require(:user).permit(:first_name, :last_name)              
            end

            def tester_params
                params.require(:tester_profile).permit(:address1, :address2, :province, :skype_id, :zip_code, 
                :mobile_number, :gender, :born_year, :paypal_email)
            end

            def company_params
                params.require(:company_profile).permit(:company_name, :company_url)
            end
        end
    end
end