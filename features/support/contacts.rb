def create_contacts
  [
    'Department for Work and Pensions (DWP)',
    'Ministry of Defence (MoD)',
    'Child Support Agency'
  ].map { |name| Factory.create :contact, :name => name }
end

def check_contacts_appear_in_order(contacts)
  assert_equal contacts.map(&:name).sort, all('#contacts a').map(&:text)
end

def create_contact
  Factory.create :contact,
    :name           => 'Department for Environment, Food and Rural Affairs',
    :postal_address => "Customer Contact Unit\nEastbury House\n30-34 Albert Embankment\nLondon\nSE1 7TL",
    :email_address  => 'helpline@defra.gsi.gov.uk',
    :website_url    => 'http://www.defra.gov.uk/',
    :opening_hours  => 'Monday to Friday 8.00 am to 6.00 pm (helpline)'
end

def check_attribute_appears(name, value)
  within :xpath, XPath.generate { |x| x.descendant(:p)[x.descendant(:strong)[XPath::HTML.content(name)]] } do
    assert has_content? value if value.present?
  end
end

def check_contact_name_appears(name)
  check_attribute_appears 'Name', name
end

def check_contact_postal_address_appears(postal_address)
  postal_address.split(/\n/).each do |postal_address_line|
    check_attribute_appears 'Postal address', postal_address_line
  end
end

def check_contact_details_appear(contact)
  check_contact_name_appears contact.name
  check_contact_postal_address_appears contact.postal_address
  check_attribute_appears 'Email address', contact.email_address
  check_attribute_appears 'Website URL', contact.website_url
  check_attribute_appears 'Opening hours', contact.opening_hours
end

def enter_contact_details(name)
  fill_in 'Name', :with => name
  click_button 'Create Contact'
end

def update_contact_name(name)
  fill_in 'Name', :with => name
  click_button 'Update Contact'
end
