class ContactsController < InheritedResources::Base
  respond_to :html
  actions :index
end
