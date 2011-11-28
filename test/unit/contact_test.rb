require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  test '#uri should return the contact\'s URI' do
    contact = Factory.build :contact, :id => 42
    assert_equal 'http://contactotron.test.gov.uk/contacts/42', contact.uri
  end
end
