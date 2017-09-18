json.message @message
json.status @status
json.brand do
    json.id                       @new_brand.id
    json.name                     @new_brand.name
end
