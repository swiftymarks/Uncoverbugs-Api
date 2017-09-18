module Api
  module V1
    class BrandsController < ApplicationController
      before_action :authenticate_request   
      rescue_from ApiExceptions::BrandError::RoleMismatchError, :with => :render_unauthorized
      
      def fetch_all_brands
        @brands = Brand.all
        @status = :ok
        @message = "Brands Fetched"        
      end
    end
  end
end