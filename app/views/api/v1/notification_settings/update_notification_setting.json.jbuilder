json.message @message
json.status @status
json.notification_setting do
  json.id                           @current_user.tester.notification_setting.id  
  json.newsletter                   @notification_setting.newsletter
  json.notify_new_project           @notification_setting.notify_new_project
  json.notify_work_evaluation       @notification_setting.notify_work_evaluation
  json.notify_events                @notification_setting.notify_events
end