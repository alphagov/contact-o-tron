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
  Factory.create :contact, :name => 'Department for Environment, Food and Rural Affairs'
end

def check_attribute_appears(name, value)
  within :xpath, XPath.generate { |x| x.descendant(:p)[x.descendant(:strong)[XPath::HTML.content(name)]] } do
    assert has_content? value if value.present?
  end
end

def check_contact_name_appears(name)
  check_attribute_appears 'Name', name
end

def check_contact_details_appear(contact)
  check_contact_name_appears contact.name
end
