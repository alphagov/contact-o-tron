def flush_notifications
  FakeTransport.instance.flush
end

def latest_notification_with_destination(destination)
  notifications = FakeTransport.instance.notifications
  notifications.reverse.detect { |n| n[:destination] == destination }
end

def check_create_notification(contact)
  notification = latest_notification_with_destination '/topic/marples.contactotron.contacts.created'
  assert_not_nil notification
  assert_equal contact.uri, notification[:message][:contact][:uri]
end

def check_update_notification(contact)
  notification = latest_notification_with_destination '/topic/marples.contactotron.contacts.updated'
  assert_not_nil notification
  assert_equal contact.uri, notification[:message][:contact][:uri]
end
