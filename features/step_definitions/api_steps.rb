Then /^the API should show the new contact$/ do
  check_contact_is_in_api @contact
end

Then /^the API should show the updated name$/ do
  check_contact_has_name_in_api @contact, 'Updated name'
end

Then /^the API should show the updated postal address$/ do
  check_contact_has_postal_address_in_api @contact, "Updated\npostal\naddress"
end

Then /^the API should show the updated phone number$/ do
  check_contact_has_phone_number_in_api @contact, 'minicom', 'Minicom', '0845 123 1234'
end

Then /^the API should show the new phone number$/ do
  check_contact_has_phone_number_in_api @contact, 'phone', 'Hotline', '020 725 3490'
end

Then /^the API should not show the old phone number$/ do
  check_contact_does_not_have_phone_number_in_api @contact, 'minicom', 'Minicom', '0845 300 1998'
end
