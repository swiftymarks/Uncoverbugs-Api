class TestPlan < ApplicationRecord
    enum testing_type: { explatory: 0, case_driven: 1 }
    validates :testing_url, presence: true
    validates :step_explanation, presence: true
    validates :name, presence: true
    validates :minimum_time, presence: true
    validates :is_fix, presence: true
    validates :testing_type, inclusion: { in: TestPlan.testing_types.keys }
    belongs_to :project
    has_one :project_module, :through => :test_plan_project_modules
    has_and_belongs_to_many :devices
    def self.random_testing_type
        TestPlan.testing_types.keys.sample
    end
end