def contact_data_from_api(contact)
  visit contact_path(contact, :format => :json)
  ActiveSupport::JSON.decode(source).with_indifferent_access
end

def check_contact_is_in_api(contact)
  assert_equal contact.attributes.with_indifferent_access, contact_data_from_api(contact)
end

def check_contact_has_name_in_api(contact, name)
  assert_equal name, contact_data_from_api(contact)[:name]
end

def check_contact_has_postal_address_in_api(contact, postal_address)
  assert_equal postal_address, contact_data_from_api(contact)[:postal_address]
end
