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
