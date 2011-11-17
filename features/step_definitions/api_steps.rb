Then /^the API should show the new contact$/ do
  check_contact_is_in_api @contact
end

Then /^the API should show the updated name$/ do
  check_contact_has_name_in_api @contact, 'Updated name'
end

Then /^the API should show the updated postal address$/ do
  check_contact_has_postal_address_in_api @contact, "Updated\npostal\naddress"
end
