class ContactsController < InheritedResources::Base
  respond_to :html
  actions :index, :show, :new, :edit, :create, :update
end
