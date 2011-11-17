class ContactsController < InheritedResources::Base
  respond_to :html
  respond_to :json, :only => :show
  actions :index, :show, :new, :edit, :create, :update
end
