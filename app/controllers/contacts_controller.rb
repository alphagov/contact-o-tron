class ContactsController < InheritedResources::Base
  respond_to :html
  respond_to :json, :only => :show
  actions :index, :show, :new, :edit, :create, :update

  before_filter :authenticate_user!, :unless => lambda { |c|
    c.action_name == 'show' && c.request.format.json?
  }

  def show
    show! do |format|
      format.json { render :json => @contact.as_json(:include => :phone_numbers) }
    end
  end
end
