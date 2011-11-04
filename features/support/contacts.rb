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
