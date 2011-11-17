def contact_data_from_api(contact)
  visit contact_path(contact, :format => :json)
  ActiveSupport::JSON.decode(source).with_indifferent_access
end

def check_contact_is_in_api(contact)
  assert_equal contact.attributes.with_indifferent_access, contact_data_from_api(contact).except(:phone_numbers)
end

def check_contact_has_name_in_api(contact, name)
  assert_equal name, contact_data_from_api(contact)[:name]
end

def check_contact_has_postal_address_in_api(contact, postal_address)
  assert_equal postal_address, contact_data_from_api(contact)[:postal_address]
end

def phone_numbers_from_api(contact)
  contact_data_from_api(contact)[:phone_numbers].map { |phone_number| phone_number.values_at(:kind, :label, :value) }
end

def check_contact_has_phone_number_in_api(contact, kind, label, value)
  assert_include phone_numbers_from_api(contact), [kind, label, value]
end

def check_contact_does_not_have_phone_number_in_api(contact, kind, label, value)
  assert_not_include phone_numbers_from_api(contact), [kind, label, value]
end
