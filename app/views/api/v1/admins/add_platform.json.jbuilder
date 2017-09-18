json.message @message
json.status @status
json.platform do
    json.id                       @new_platform.id
    json.name                     @new_platform.name
end
