def create_contacts
  [
    'Department for Work and Pensions (DWP)',
    'Ministry of Defence (MoD)',
    'Child Support Agency'
  ].map { |name| Factory.create :contact, :name => name }
end

def check_contacts_appear_in_order(contacts)
  assert_equal contacts.map(&:name).sort, all('.contacts a').map(&:text)
end

def create_contact
  phone_numbers = [
    { kind: 'phone',    label: 'Defra Helpline',  value: '0845 933 5577' },
    { kind: 'minicom',  label: 'Minicom',         value: '0845 300 1998' },
    { kind: 'fax',                                value: '020 7238 2188' }
  ].map do |attributes|
    Factory.build :phone_number, attributes
  end

  Factory.create :contact,
    :name           => 'Department for Environment, Food and Rural Affairs',
    :postal_address => "Customer Contact Unit\nEastbury House\n30-34 Albert Embankment\nLondon\nSE1 7TL",
    :phone_numbers  => phone_numbers,
    :email_address  => 'helpline@defra.gsi.gov.uk',
    :website_url    => 'http://www.defra.gov.uk/',
    :opening_hours  => 'Monday to Friday 8.00 am to 6.00 pm (helpline)'
end

def check_attribute_appears(name, value)
  within :xpath, XPath.generate { |x| x.descendant(:dt)[XPath::HTML.content(name)].next_sibling(:dd) } do
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

def check_contact_phone_number_appears(kind, label, value)
  check_attribute_appears "#{kind.humanize} number#{" (#{label})" if label.present?}", value
end

def check_contact_phone_number_does_not_appear(kind, label, value)
  assert !has_selector?(:xpath, XPath.generate { |x| x.descendant(:p)[XPath::HTML.content(value)] })
end

def check_contact_details_appear(contact)
  check_contact_name_appears contact.name
  check_contact_postal_address_appears contact.postal_address
  contact.phone_numbers.each do |phone_number|
    check_contact_phone_number_appears phone_number.kind, phone_number.label, phone_number.value
  end

  check_attribute_appears 'Email address', contact.email_address
  check_attribute_appears 'Website URL', contact.website_url
  check_attribute_appears 'Opening hours', contact.opening_hours
end

def enter_contact_details(name)
  fill_in 'Name', :with => name
  click_button 'Create Contact'
end

def click_update_contact_button
  click_button 'Update Contact'
end

def update_contact_name(name)
  fill_in 'Name', :with => name
  click_update_contact_button
end

def update_contact_postal_address(postal_address)
  fill_in 'Postal address', :with => postal_address
  click_update_contact_button
end

def within_phone_number(kind, label, &block)
  within :xpath, XPath.generate { |x| x.descendant(:div)[XPath::HTML.select('Kind', :selected => kind) && XPath::HTML.fillable_field('Label', :with => label)] }, &block
end

def fill_in_phone_number(kind, label, value)
  select kind, :from => 'Kind'
  fill_in 'Label', :with => label
  fill_in 'Number', :with => value
end

def update_contact_phone_number(kind, label, value)
  within_fieldset 'Phone numbers' do
    within_phone_number kind, label do
      fill_in_phone_number kind, label, value
    end
  end

  click_update_contact_button
end

def add_contact_phone_number(kind, label, value)
  within_fieldset 'Phone numbers' do
    within :xpath, './/div[last()]' do
      fill_in_phone_number kind, label, value
    end
  end

  click_update_contact_button
end

def remove_contact_phone_number(kind, label, value)
  within_fieldset 'Phone numbers' do
    within_phone_number kind, label do
      check 'Delete'
    end
  end

  click_update_contact_button
end
