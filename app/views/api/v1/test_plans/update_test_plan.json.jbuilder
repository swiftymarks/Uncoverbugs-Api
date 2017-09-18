json.message @message
json.status @status
json.test_plan do
  json.id                            @test_plan.id
  json.step_explanation              @test_plan.step_explanation
  json.name                          @test_plan.name
  json.minimum_time                  @test_plan.minimum_time
  json.is_fix                        @test_plan.is_fix
  json.testing_type                  @test_plan.testing_type
  json.script_file                   @test_plan.script_file
end