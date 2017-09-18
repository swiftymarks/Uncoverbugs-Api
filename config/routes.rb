Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/ping',                                      to: 'webhooks#ping'
      
      post '/authentications/signup_as_tester',         to: 'authentications#signup_as_tester'
      post '/authentications/signup_as_company',        to: 'authentications#signup_as_company'      
      post '/authentications/signin_email',             to: 'authentications#signin_email'      
      post '/authentications/signin_username',          to: 'authentications#signin_username'      
      post '/authentications/signin_as_admin',          to: 'authentications#signin_as_admin'      
      
      get '/users/profile',                             to: 'users#fetch_profile'      
      put '/users/profile/tester',                      to: 'users#update_tester_profile'      
      put '/users/profile/company',                     to: 'users#update_company_profile'  
      
      post '/users/testers_devices/add',                to: 'testers_devices#add_tester_device'
      
      get  '/notification_settings',                     to: 'notification_settings#fetch_notification_setting' 
      put  '/notification_settings',                     to: 'notification_settings#update_notification_setting'       
      
      get  '/devices',                                   to: 'devices#fetch_all_devices' 
      get  '/brands',                                    to: 'brands#fetch_all_brands' 
      get  '/platforms',                                 to: 'platforms#fetch_all_platforms' 
      get  '/operating_systems',                         to: 'operating_systems#fetch_all_operating_systems'       
      
      post '/admins/brands/create',                               to: 'admins#add_brand'      
      post '/admins/operating_systems/create',                    to: 'admins#add_operating_system'
      post '/admins/platforms/create',                            to: 'admins#add_platform'
      post '/admins/devices/create',                              to: 'admins#create_new_device'  
      put  '/admins/devices/update',                              to: 'admins#update_device'       
      
      get  '/projects',                            to: 'projects#fetch_projects'      
      post '/projects/create',                     to: 'projects#create_new_project'
      put '/projects/update',                     to: 'projects#update_project'

      get  '/project_modules',                            to: 'project_modules#fetch_projects'      
      post '/project_modules/create',                     to: 'project_modules#create_project_module'
      put '/project_modules/update',                     to: 'project_modules#update_project'
      
      post '/test_plans/create',                            to: 'test_plans#create_test_plan'
      get  '/test_plans',                                   to: 'test_plans#fetch_test_plans'      
      put  '/test_plans/update',                            to: 'test_plans#update_test_plan'      
      delete '/test_plans/delete',                          to: 'test_plans#delete_test_plan'
      
      post '/test_plans/devices/create',                    to: 'test_plans#add_test_plan_device'
    end
  end
end