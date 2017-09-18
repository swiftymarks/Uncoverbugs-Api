class ProjectModule < ApplicationRecord
    validates :name, presence: true    
    belongs_to :project
    has_many :test_plans, :through => :test_plan_project_modules
end
