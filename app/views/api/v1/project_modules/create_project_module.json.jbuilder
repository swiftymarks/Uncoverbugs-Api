json.message @message
json.status @status
json.project_module do
  json.id       @new_project_module.id
  json.name     @new_project_module.name
end