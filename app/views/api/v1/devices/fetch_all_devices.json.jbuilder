json.message @message
json.status @status
json.data do
    json.devices @devices, :id, :model, :brand, :browser, :operating_system
end