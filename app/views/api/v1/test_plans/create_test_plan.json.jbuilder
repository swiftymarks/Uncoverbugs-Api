json.message @message
json.status @status
json.test_plan do
  json.id                            @new_test_plan.id
  json.step_explanation              @new_test_plan.step_explanation
  json.name                          @new_test_plan.name
  json.minimum_time                  @new_test_plan.minimum_time
  json.is_fix                        @new_test_plan.is_fix
  json.script_file                   @new_test_plan.script_file
  json.testing_type                  @new_test_plan.testing_type  
end