module ContactsHelper
  def phone_numbers_for(contact)
    new_phone_numbers, existing_phone_numbers = contact.phone_numbers.partition(&:new_record?)
    existing_phone_numbers + (new_phone_numbers.presence || [PhoneNumber.new])
  end
end
