class ApplicationController < ActionController::API

    def authenticate_request 
        @current_user = AuthorizeApiRequest.call(request.headers).result 
        render json: { error: 'Not Authorized' }, status: 401 unless @current_user 
    end

    def render_bad_request(error)
        render json: error, serializer: ApiExceptionSerializer, status: :bad_request
    end

    def render_not_found(error)
        render json: error, serializer: ApiExceptionSerializer, status: :not_found
    end

    def render_unauthorized(error)
        render json: error, serializer: ApiExceptionSerializer, status: :unauthorized
    end

    def render_unprocessable_entity(error)
        render json: error, serializer: ApiExceptionSerializer, status: :unprocessable_entity
    end

    def render_server_error(error)
        render json: error, serializer: ApiExceptionSerializer, status: :internal_server_error
    end
end
