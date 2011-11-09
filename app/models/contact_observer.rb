class ContactObserver < ActiveRecord::Observer
  def after_create(contact)
    Messenger.instance.created contact
  end

  def after_update(contact)
    Messenger.instance.updated contact
  end
end
