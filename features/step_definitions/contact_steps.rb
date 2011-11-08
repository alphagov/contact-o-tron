Given /^some contacts exist$/ do
  @contacts = create_contacts
end

Then /^I should be able to see all the contacts in alphabetical order$/ do
  visit contacts_path
  check_contacts_appear_in_order @contacts
end

Given /^a contact exists$/ do
  @contact = create_contact
end

Then /^I should be able to see the contact's details$/ do
  visit contact_path(@contact)
  check_contact_details_appear @contact
end

When /^I enter the details for a new contact$/ do
  visit new_contact_path
  enter_contact_details 'A new contact'
end

Then /^the contact should be created$/ do
  contact = Contact.find_by_name! 'A new contact'
  visit contact_path(contact)
  check_contact_details_appear contact
end

When /^I edit the contact's name$/ do
  visit edit_contact_path(@contact)
  update_contact_name 'Updated name'
end

Then /^the contact's name should change$/ do
  visit contact_path(@contact)
  check_contact_name_appears 'Updated name'
end

When /^I edit the contact's postal address$/ do
  visit edit_contact_path(@contact)
  update_contact_postal_address "Updated\npostal\naddress"
end

Then /^the contact's postal address should change$/ do
  visit contact_path(@contact)
  check_contact_postal_address_appears "Updated\npostal\naddress"
end
