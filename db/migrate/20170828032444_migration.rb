class Migration < ActiveRecord::Migration[5.1]
    def change
        create_table :users do |t| 
            t.string      :email  
            t.string      :password_digest
            t.integer     :user_type
            t.string      :username
            t.string      :first_name
            t.string      :last_name       
            t.timestamps
        end
        
        create_table :testers do |t|
            t.text          :address1
            t.text          :address2
            t.string        :province
            t.string        :skype_id
            t.integer       :zip_code
            t.string        :mobile_number
            t.integer       :gender
            t.integer       :born_year
            t.string        :paypal_email
            t.belongs_to    :user        
            t.timestamps
        end
        
        create_table :companies do |t|
            t.string      :company_name
            t.string      :company_url
            t.belongs_to  :user        
            t.timestamps
        end

        create_table :platforms do |t|
            t.string      :name
            t.timestamps
        end
        
        create_table :brands do |t|
            t.string      :name
            t.timestamps
        end
        
        create_table :operating_systems do |t|
            t.string      :name
            t.timestamps
        end
        
        create_table :devices do |t|
            t.string      :brand
            t.string      :model
            t.string      :browser
            t.string      :platform        
            t.string      :operating_system
            t.timestamps
        end

        create_table :tester_devices do |t|
            t.belongs_to  :tester, index: true
            t.belongs_to  :device, index: true
        end
        
        create_table :projects do |t|
            t.string        :name
            t.integer       :testing_type
            t.string        :version
            t.string        :testing_site
            t.text          :objective
            t.integer        :language
            t.string        :result_email
            t.belongs_to    :company            
            t.timestamps
        end
        
        create_table :project_modules do |t|
            t.string      :name
            t.belongs_to  :project                    
            t.timestamps
        end
        
        create_table :notification_settings do |t|
            t.boolean       :newsletter,              :default => true
            t.boolean       :notify_new_project,      :default => true
            t.boolean       :notify_work_evaluation,  :default => true
            t.boolean       :notify_events,           :default => true
            t.belongs_to    :tester        
            t.timestamps
        end
        
        create_table :test_plans do |t|
            t.string      :testing_url
            t.text        :step_explanation
            t.string      :name
            t.integer     :minimum_time
            t.boolean     :is_fix
            t.integer     :testing_type
            t.string      :script_file
            t.belongs_to  :project                
            t.timestamps
        end

        create_table :test_plan_project_modules do |t|
            t.belongs_to  :test_plans
            t.belongs_to  :project_modules
            t.timestamps
        end

        create_table :devices_test_plans do |t|
            t.belongs_to  :test_plan
            t.belongs_to  :device
            t.timestamps
        end
    end
end