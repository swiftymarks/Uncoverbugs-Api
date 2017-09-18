json.message @message
json.status @status
json.operating_system do
    json.id                       @new_operating_system.id
    json.name                     @new_operating_system.name
end
