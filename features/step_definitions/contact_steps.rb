Given /^we're using the GDS-SSO stub strategy$/ do
  User.create!(:name => "Fake User", :email => 'fake@user.com', :version => 1, :uid => '12345')
end

Given /^some contacts exist$/ do
  @contacts = create_contacts
  flush_notifications
end

Then /^I should be able to see all the contacts in alphabetical order$/ do
  visit contacts_path
  check_contacts_appear_in_order @contacts
end

Given /^a contact exists$/ do
  @contact = create_contact
  flush_notifications
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
  @contact = Contact.find_by_name! 'A new contact'
  visit contact_path(@contact)
  check_contact_details_appear @contact
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

When /^I edit the contact's phone number$/ do
  visit edit_contact_path(@contact)
  update_contact_phone_number 'minicom', 'Minicom', '0845 123 1234'
end

Then /^the contact's phone number should change$/ do
  visit contact_path(@contact)
  check_contact_phone_number_appears 'minicom', 'Minicom', '0845 123 1234'
end

When /^I add a phone number to the contact$/ do
  visit edit_contact_path(@contact)
  add_contact_phone_number 'phone', 'Hotline', '020 725 3490'
end

When /^I remove a phone number from the contact$/ do
  visit edit_contact_path(@contact)
  remove_contact_phone_number 'minicom', 'Minicom', '0845 300 1998'
end

Then /^the contact's details should (not )?include the phone number$/ do |should_not|
  visit contact_path(@contact)

  if should_not
    check_contact_phone_number_does_not_appear 'minicom', 'Minicom', '0845 300 1998'
  else
    check_contact_phone_number_appears 'phone', 'Hotline', '020 725 3490'
  end
end
