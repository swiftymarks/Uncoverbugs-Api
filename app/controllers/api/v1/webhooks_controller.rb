module Api
    module V1
        class WebhooksController < ApplicationController
            def ping
                render json: { message: "Hello, World" }
            end
        end
    end
end