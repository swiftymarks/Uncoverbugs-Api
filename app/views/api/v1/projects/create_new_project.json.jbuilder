json.message @message
json.status @status
json.project do
  json.id                @new_project.id
  json.name              @new_project.name
  json.version           @new_project.version
  json.tesing_site       @new_project.testing_site
  json.testing_type      @new_project.testing_type
  json.objective         @new_project.objective
  json.language          @new_project.language
  json.result_email      @new_project.result_email
  json.project_modules   @new_project.project_modules, :id, :name
end