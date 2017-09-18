class Project < ApplicationRecord
    enum testing_type: { functional_testing: 0, usability_testing: 1, load_testing: 2, security_testing: 3 }
    enum language: { english: 0, tagalog: 1, taglish: 2 }    
    validates :name, presence: true
    validates :testing_type, presence: true, inclusion: { in: Project.testing_types.keys }    
    validates :version, presence: true
    validates :objective, presence: true
    validates :language, presence: true,  inclusion: { in: Project.languages.keys }
    validates :result_email, presence: true

    belongs_to :company    
    has_one :platform
    has_many :test_plans
    has_many :project_modules

    def self.random_testing_type
        Project.testing_types.keys.sample
    end

    def self.random_language
        Project.languages.keys.sample        
    end
end