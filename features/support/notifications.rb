def flush_notifications
  FakeTransport.instance.flush
end

def latest_notification
  notifications = FakeTransport.instance.notifications
  assert_not_empty notifications
  notifications.last
end

def check_create_notification(contact)
  assert_equal '/topic/marples.contactotron.contacts.created', latest_notification[:destination]
  assert_equal contact.id, latest_notification[:message][:contact][:id]
end

def check_update_notification(contact)
  assert_equal '/topic/marples.contactotron.contacts.updated', latest_notification[:destination]
  assert_equal contact.id, latest_notification[:message][:contact][:id]
end
