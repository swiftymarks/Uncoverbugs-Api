json.message @message
json.status @status
json.project do
  json.id                @project.id
  json.name              @project.name
  json.version           @project.version
  json.tesing_site       @project.testing_site
  json.testing_type      @project.testing_type
  json.objective         @project.objective
  json.language          @project.language
  json.result_email      @project.result_email
end