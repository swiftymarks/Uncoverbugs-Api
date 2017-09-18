json.message @message
json.status @status
json.data do
    json.device do
        json.id                        @device.id
        json.model                     @device.model
        json.brand                     @device.brand
        json.browser                   @device.browser
        json.operating_system          @device.operating_system
    end
end
