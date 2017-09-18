json.message @message
json.status @status
json.device do
  json.id                            @device.id
  json.brand                         @device.brand
  json.browser                       @device.browser
  json.operating_system              @device.operating_system
end