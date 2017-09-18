json.message @message
json.status @status
json.notification_setting do
  json.id                           @current_user.tester.notification_setting.id
  json.newsletter                   @current_user.tester.notification_setting.newsletter
  json.notify_new_project           @current_user.tester.notification_setting.notify_new_project
  json.notify_work_evaluation       @current_user.tester.notification_setting.notify_work_evaluation
  json.notify_events                @current_user.tester.notification_setting.notify_events
end