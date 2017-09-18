class TestPlanProjectModule < ApplicationRecord
  belongs_to :test_plan
  belongs_to :project_module
end