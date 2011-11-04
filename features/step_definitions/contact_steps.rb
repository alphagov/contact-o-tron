Given /^some contacts exist$/ do
  @contacts = create_contacts
end

Then /^I should be able to see all the contacts in alphabetical order$/ do
  visit contacts_path
  check_contacts_appear_in_order @contacts
end
