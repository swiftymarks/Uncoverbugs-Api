json.message @message
json.status @status
json.device do
    json.id                        @new_device.id
    json.model                     @new_device.model
    json.brand                     @new_device.brand
    json.platform                  @new_device.platform        
    json.browser                   @new_device.browser
    json.operating_system          @new_device.operating_system
end
