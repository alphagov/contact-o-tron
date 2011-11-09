Then /^the rest of the system should be notified that the contact has been created$/ do
  check_create_notification @contact
end

Then /^the rest of the system should be notified that the contact has been updated$/ do
  check_update_notification @contact
end
