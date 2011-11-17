class ContactsController < InheritedResources::Base
  respond_to :html
  respond_to :json, :only => :show
  actions :index, :show, :new, :edit, :create, :update

  def show
    show! do |format|
      format.json { render :json => @contact.as_json(:include => :phone_numbers) }
    end
  end
end
